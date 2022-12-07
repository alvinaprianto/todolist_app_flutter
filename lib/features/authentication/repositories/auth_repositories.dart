import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/main_screen.dart';

class AuthRepositories {
  static void registerFirebase(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, MainScreen.routeName);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
