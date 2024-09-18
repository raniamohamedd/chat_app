import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application9/widget/user_image.dart';

final fireb = FirebaseAuth.instance;

class auth extends StatefulWidget {
  const auth({super.key});

  @override
  State<auth> createState() => _authState();
}

class _authState extends State<auth>with TickerProviderStateMixin  {
  final GlobalKey<FormState>  forek = GlobalKey<FormState>();
  var islogin = true;
  var enteremail = '';
  var enteredoass = '';
  var entereduser = '';
   var isloading = false;
  File? selectedimage;



  
  late AnimationController anc3;

  late Animation<Offset> an3;
 
 void initState() {
    // TODO: implement initState
    super.initState();
     anc3 = AnimationController
     (vsync: this,
      duration: Duration(seconds: 3))
      ..animateTo(2);
    an3 = Tween<Offset>(begin: Offset(2,1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: anc3, curve: Curves.bounceIn));
  }
   void dispose() {
    // TODO: implement dispose
    super.dispose();

    anc3.dispose();
  }


  void submit() async {
    final valid = forek.currentState!.validate();
    if (!valid || (!islogin&&selectedimage==null)) {
      return;
    }  
    
    
    
    
    
     try {
      setState(() {
        isloading = true;
      });
    if (islogin) {
final UserCredential usercred =
            await fireb.signInWithEmailAndPassword(
                email: enteremail, password: enteredoass);


    
  }
    else {
   
        final UserCredential usercred =
            await fireb.createUserWithEmailAndPassword(
                email: enteremail, password: enteredoass);
        final storageref =  FirebaseStorage.instance.
          ref().child('user_images')
          .child('${usercred.user!.uid}.jpg');
       await   storageref.putFile(selectedimage!);
        final imageurl =  await storageref.getDownloadURL();
          log(imageurl);
      await FirebaseFirestore.instance.collection('users').doc(usercred.user!.uid).set({
        'name':entereduser,
        'email' : enteremail,
          'image_url' : imageurl
      });

      }}
      on FirebaseAuthException 
       catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();  
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message??'ERROR')))    ;
       
        setState(() {
          isloading =false;
        });
      }
    
    forek.currentState!.save();
    log(enteremail);
    log(enteredoass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Container(
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [if(islogin)
                  SlideTransition(
                    position: an3,
                    
                    child: Container(
                              
                      margin:
                          EdgeInsets.only(top: 30,  right: 20, left: 20),
                      width: 230,
                      child: Image.asset('images/k.png'),
                    ),
                  ),
                  Container(
                     child: Padding(
                        padding: EdgeInsets.all(15),
                   // decoration: BoxDecoration(color: const Color.fromARGB(255, 161, 131, 38).withOpacity(.5)),
                  
                     // color: Color.fromARGB(54, 12, 58, 145).withOpacity(.5),
                    //  margin: EdgeInsets.all(20),
                     
                        child: Form(
                          
                          key: forek,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,right: 15,top: 32,bottom: 0),
                              child: Column(
                                children: [
                                  if(!islogin)
                                   UserImage(onpicked: (File pickedimage) { selectedimage =pickedimage; },),
                                     if(!islogin)
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Username'),
                                   // keyboardType: TextInputType.emailAddress,
                                   // autocorrect: false,
                                  //  textCapitalization: TextCapitalization.none,
                                    onSaved: (value) => entereduser = value!,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().length<4 ) {
                                        return 'please enter at least 4 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Email address'),
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    textCapitalization: TextCapitalization.none,
                                    onSaved: (value) => enteremail = value!,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty ||
                                          !value.contains('@')) {
                                        return 'please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                
                                  TextFormField(
                                      decoration:
                                          InputDecoration(labelText: 'Password'),
                                      obscureText: true,
                                      onSaved: (value) => enteredoass = value!,
                                      validator: (value) {
                                        if (value == null || value.trim().length < 6) {
                                          return 'password must be at least 6 characters long';
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: 52,
                                  ),
                                  if(isloading) CircularProgressIndicator(),
                                  if(!isloading)
                                  ElevatedButton(
                                    onPressed: submit,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:Color.fromARGB(209, 190, 243, 239)),
                                    child: Text(islogin ? 'Login ' : 'Sign up'),
                                  ),
                                  SizedBox(height: 12,),
                                  if(!isloading)
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        islogin = !islogin;
                                      });
                                    },
                                    child: Text(islogin
                                        ? 'Create an account ? '
                                        : 'I already have an account '),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
