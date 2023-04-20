import 'dart:async';

import 'package:chat_up/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../animations/fade_animation.dart';
import '../apis/apis.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      if (APIs.auth.currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeAnimation(
                          1.1,
                          Container(
                            width: 280,
                            height: 280,
                            child: Icon(
                              Icons.mark_unread_chat_alt_outlined,
                              size: 160,
                              color: Colors.pink,
                            ),
                          )),
                      FadeAnimation(
                          1.3,
                          Text(
                            "Chat Up",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5),
                          )),
                    ],
                  ),
                ),
                FadeAnimation(
                  1.4,
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "From\nAnurag Kashyap",
                      style: TextStyle(fontSize: 12, letterSpacing: 0.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
