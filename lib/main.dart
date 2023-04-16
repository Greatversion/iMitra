import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imitra/screens/homescreen.dart';
import 'package:imitra/screens/login_functionality/logincheck.dart';
import 'package:imitra/screens/login_functionality/loginscreen.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "HomeScreen": (context) => const HomeScreen(),
        "LoginScreen": (context) => const SignInScreen(),
      },
      home: const LoginCheck(),
    );
  }
}
