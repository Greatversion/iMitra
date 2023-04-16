import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginCheck extends StatefulWidget {
  const LoginCheck({super.key});

  @override
  State<LoginCheck> createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  Future<void> checkCurrentUser(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? googleUser = _auth.currentUser;
    if (googleUser != null) {
      const Center(child: CircularProgressIndicator());
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, "HomeScreen");
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, "LoginScreen");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkCurrentUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var responsive = MediaQuery.of(context);
    return Container(
        height: responsive.size.height,
        width: responsive.size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 8, 78, 135),
          Color.fromARGB(255, 11, 9, 37)
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(curve: Curves.bounceOut, duration: const Duration(seconds: 2), child: Image.asset("assets/login_image.jpg")),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.only(top: 80),
              height: 60,
              child: Image.asset("assets/text.png"),
            ),
          ],
        ));
  }
}
