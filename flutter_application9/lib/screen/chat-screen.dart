import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application9/widget/chatmessages.dart';
import 'package:flutter_application9/widget/newmessage.dart';

class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      actions: [IconButton(onPressed: (){

      FirebaseAuth.instance.signOut();



      }, icon: Icon(Icons.exit_to_app),color: Theme.of(context).colorScheme.primary,)],
      
      
      title: Text('Chat',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),)
    
    
    
    ,body:Column(children: [Expanded(child: Chatmessages()),newm()],));
  }
}