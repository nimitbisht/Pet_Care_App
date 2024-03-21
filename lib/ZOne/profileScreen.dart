import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Auth/authentication.dart';

class profileScreen extends StatelessWidget {
  profileScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  gsignOut() async {
    await Authentication().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              gsignOut();
              signOut();
              Navigator.pop(context); // pop current screen
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Text.rich(
          TextSpan(
            style: const TextStyle(),
            children: [
              TextSpan(
                text: '\nWelcome ${user.email!.split('@')[0]}  \n\n',
                style: const TextStyle(
                  fontSize: 37,
                  fontFamily: 'Quicksand',
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                  height: 2,
                ),
              ),
              TextSpan(
                text: 'Email ID : ${user.email!}   ',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Quicksand',
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  height: 2,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gsignOut();
          signOut();
          Navigator.pop(context); // pop current screen
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.logout), // Set the desired background color
      ),
    );
  }
}
