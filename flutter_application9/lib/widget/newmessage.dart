import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class newm extends StatefulWidget {
  const newm({super.key});

  @override
  State<newm> createState() => _newmState();
}

class _newmState extends State<newm> {
  final  mcon = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mcon.dispose();
  }
  sendm()async{
   final enterm= mcon.text;
   if(enterm.trim().isEmpty){
    return;
   }

FocusScope.of(context).unfocus();

mcon.clear();



final User user = FirebaseAuth.instance.currentUser!;
final userdata= await FirebaseFirestore.instance.collection('users').doc(user.uid).get(
      );

  await FirebaseFirestore.instance.collection('chat').
 add({
        'text':enterm,
        'createdat' : Timestamp.now(),
        'userid' :  user.uid,
        'username' :  userdata.data()!['name'],
          'image_url' : userdata.data()!['image_url']
      });


  }
  @override
  Widget build(BuildContext context) {
    return Padding
    
    (padding: EdgeInsets.only(left: 15,bottom:14,right: 1 ),
    child: Row(children: [
      Expanded(child: TextField(
        controller: mcon,
        decoration: InputDecoration(labelText: 'send message'),
       autocorrect: true,
       textCapitalization: TextCapitalization.sentences,
       enableSuggestions: true,



      )),
      IconButton(onPressed:sendm, icon: Icon(Icons.send,color: Theme.of(context).colorScheme.primary,))




    ],),);
  }
}