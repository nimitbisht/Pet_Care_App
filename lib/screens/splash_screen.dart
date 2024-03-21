import 'dart:async';

import 'package:flutter/material.dart';

import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.blue[700],
        child: const Center(
          child: Text(
            "Pet Care App",
            style: TextStyle(
                color: Colors.white, fontSize: 34, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
