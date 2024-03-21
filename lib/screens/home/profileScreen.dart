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
      body: Align (
        // child: Text.rich(
        //     Text("Logged in as: ${user.email!}")),
        alignment: Alignment.topCenter,

        child:Text.rich(
          TextSpan(
            style: const TextStyle(
            ),
            children: [
              TextSpan(
                text: '\nWelcome ${user.email!.split('@')[0]}  \n\n',

                // text: 'Logged in as: ${user.email!}   ',
                // text: 'Logged in as: ${user.uid}   ',
                // text: '${FirebaseAuth.instance.currentUser}   ',
                style: const TextStyle(
                  fontSize: 37,
                  fontFamily: 'Quicksand',
                  // fontFamily: 'Spartan MB',
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
        ), //title of









      ),
    );
  }
}
