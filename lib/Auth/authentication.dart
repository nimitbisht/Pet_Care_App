import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_care/screens/login/login_screen.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;

  var context = const LoginScreen();

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  signOut() async {
    final googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();
    await auth.signOut();
  }

  signInGoogle() async {

    // create instance of the firebase auth and sign in
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // trigger the authentication flow
    final googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // Create a new credentails
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      // sign in user with the credentails
      // print(googleUser.displayName);
      // print(googleUser.email);
      // print(googleUser);
      UserCredential userCredential = await auth.signInWithCredential(credential);
      User? user = userCredential.user;

      // check user and add data to forebase
      if (user != null) {
        await FirebaseFirestore.instance.collection('Users').add({
          'name': user.displayName,
          'email': user.email,
          'password': " ",
          'Phone Number': " ",
        });
      }
    }
  }
}
