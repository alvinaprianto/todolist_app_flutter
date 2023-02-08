import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositories {
  final _auth = FirebaseAuth.instance;
  registerFirebase(BuildContext context, String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  loginFirebase(BuildContext context, String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  signInGoogle() async {
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await account?.authentication;

    if (account == null) return null;
    final credential = GoogleAuthProvider.credential(
        idToken: googleAuth!.idToken, accessToken: googleAuth.accessToken);
    await _auth.signInWithCredential(credential);
  }
}
