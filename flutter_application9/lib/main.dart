import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application9/screen/chat-screen.dart';
import 'package:flutter_application9/screen/splash.dart';
import 'firebase_options.dart';
import 'package:flutter_application9/screen/auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 77, 183)),
        useMaterial3: true,
        
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
       builder: ((context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return splash();





        }
    if(snapshot.hasData){return Chatscreen();
    }
    return auth();



      })),
    );
  }
}