import 'dart:async';

import 'package:flutter/material.dart';
import 'package:turfix_admin/view/auth/login_screen.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/turfix image.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        // child: Image.asset("assets/images/turfixImage.jpeg", fit: BoxFit.cover)
      ),
    );
  }
}
