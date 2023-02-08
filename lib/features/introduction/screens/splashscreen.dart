import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';
import 'package:todolist_app_flutter/features/introduction/screens/onboarding_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splashscreen';

  static route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const SplashScreen());
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isFirstRun();
  }

  Future isFirstRun() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String? result = await storage.read(key: "isFirstRun");
    if (result == null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, OnBoardingScreen.routeName);
      });
    } else {
      final auth = FirebaseAuth.instance.currentUser;
      if (auth != null) {
        Timer(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacementNamed("/mainscreen");
        });
      } else {
        Timer(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacementNamed("/welcomescreen");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        imgSplashscreen,
        height: 100,
      ),
    ));
  }
}
