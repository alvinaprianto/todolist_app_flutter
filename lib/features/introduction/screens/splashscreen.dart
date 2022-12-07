import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';
import 'package:todolist_app_flutter/features/introduction/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splashscreen';

  static route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => SplashScreen());
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, OnBoardingScreen.routeName);
    });
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
