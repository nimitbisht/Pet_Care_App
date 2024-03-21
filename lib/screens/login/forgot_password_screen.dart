// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/components/text_fields.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final fpController = TextEditingController();

  void forPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: fpController.toString().trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Please enter your mail so that we can sent you reset email',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: fpController,
                hintText: 'Enter email',
                obscureText: false,
                icon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  forPassword();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Send email',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
