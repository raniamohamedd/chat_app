import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class splash extends StatelessWidget {
  const splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      actions: [IconButton(onPressed: (){

      FirebaseAuth.instance.signOut();



      }, icon: Icon(Icons.exit_to_app),color: Theme.of(context).colorScheme.primary,)],
      
      
      title: Text('data'),)
    ,body: Center(child: Text('loading')),);
  }
}