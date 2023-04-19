import 'package:chat_up/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDE3J4BH8UJRs9WMs-_0hHORzt7QGxZ02U',
            appId: '1:133597776523:web:0855cf1df6a60fe283e28e',
            messagingSenderId: '133597776523',
            projectId: 'chat-up-f1ae6',
            storageBucket: 'chat-up-f1ae6.appspot.com')
    );
  }else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "SegSemiBold",
        primarySwatch: Colors.pink,
      ),
      home: SplashScreen(),
    );
  }
}
