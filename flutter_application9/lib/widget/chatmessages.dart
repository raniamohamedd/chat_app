import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application9/widget/message_bubble.dart';

class Chatmessages extends StatelessWidget {
  const Chatmessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authuser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(



      stream: FirebaseFirestore.instance.collection('chat').orderBy
      ('createdat',descending: true).snapshots(), 
      builder: (ctx,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
        {return Center(child: CircularProgressIndicator(),);}


     if(!snapshot.hasData|| snapshot.data!.docs.isEmpty){

      return Center(child: Text('no message founded.'),);
     }
     if(snapshot.hasError){

      return Center(child: Text('something went wrong ...'),);
     }
     final loadedm = snapshot.data!.docs;

     return ListView.builder(
      padding: EdgeInsets.only(bottom: 40,left: 13,right: 13),
      reverse: true,
      
      itemCount: loadedm.length,
      itemBuilder: (ctx,index){
        final chatm = loadedm[index].data();
        final nextm =index+1<loadedm.length? loadedm[index+1].data():null;
        final  currmid = chatm['userid'];
        final  nextmid =nextm!=null? nextm['userid']:null;
        final bool nextuserissame = nextmid==currmid;


        if(nextuserissame){return MessageBubble.next(message: chatm['text'], 
        isMe: authuser.uid==currmid);}
        
        else{
       return MessageBubble.first(
        userImage: chatm['image_url'],
        username: chatm['username'],
         message: chatm['text'],
          isMe: authuser.uid==currmid);



        }

      });



     

      }) ;
  }}