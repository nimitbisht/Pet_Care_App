import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_care/ZOne/homescreen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pet_care/ZOne/order.dart';
import 'package:pet_care/screens/login/login_screen.dart';
import '../../Auth/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_settings/app_settings.dart';
import '../screens/home/profileScreen.dart';

import '../screens/pages/doctorReport/reportGeneration.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  DateTime timeBackPressed = DateTime.now();

  final user = FirebaseAuth.instance.currentUser!;
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  gsignOut() async {
    await Authentication().signOut();
  }

  void onTapActions(BuildContext context) {
    // call function 1
    gsignOut();
    // call function 2
    signOut();
    // navigate to profile screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // return false;

        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 1);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          const message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 14);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp), // set your desired icon
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
              // Navigator.pop(context); // pop the current route on press
            },
          ),

          title: const Text.rich(
            TextSpan(
              style: TextStyle(),
              children: [
                TextSpan(
                  text: 'Settings',
                  style: TextStyle(
                    fontSize: 24,
                    height: 2,
                  ),
                ),
              ],
            ),
          ), //title
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            // const ListTile(
            //   leading: Icon(Icons.arrow_back),
            //   trailing: Icon(Icons.menu),
            // ),

            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => profileScreen())),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => profileScreen())),

                    child: Card(
                      margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      // color: Colors.white70,
                      // color: Theme.of(context).brightness == Brightness.dark
                      //     ? Colors.black12
                      //     : Colors.white70,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: const ListTile(
                        leading: Icon(
                          LineIcons.user,
                          // color: Colors.black54,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          // color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Orders(),
                      ),
                    ),
                    child: Card(
                      margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      // color: Theme.of(context).brightness == Brightness.dark
                      //     ? Colors.black12
                      //     : Colors.white70,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: const ListTile(
                        leading: Icon(
                          LineIcons.calendarCheck,
                          // color: Colors.black54,
                        ),
                        title: Text(
                          'My Orders',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          // color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppSettings.openAppSettings();
                    },
                    child: Card(
                      margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      // color: Colors.white70,
                      // color: Theme.of(context).brightness == Brightness.dark
                      //     ? Colors.black12
                      //     : Colors.white70,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: const ListTile(
                        leading: Icon(
                          LineIcons.cog,
                          // Icons.privacy_tip_sharp,
                          // color: Colors.black54,
                        ),
                        title: Text(
                          'Permissions',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          // color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    // onTap: () => _navigateToFeedback(context),
                    onTap: () async {
                      final Uri params = Uri(
                        scheme: 'mailto',
                        path: 'pet_care@gmail.com',
                      );
                      if (await canLaunchUrl(params)) {
                        await launchUrl(params);
                      }
                    },
                    // child: const Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(
                    //     'Contact Us',
                    //     style: TextStyle(
                    //         fontSize: 30,
                    //         color: Colors.red
                    //     ),
                    //   ),
                    // )

                    child: Card(
                      // color: Colors.white70,
                      margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: const ListTile(
                        leading: Icon(
                          LineIcons.envelope,
                          // color: Colors.black54
                        ),
                        title: Text(
                          'Feedback',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          // color: Colors.black54
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorDataScreen(),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: const ListTile(
                        leading: Icon(
                          LineIcons.user,
                          // color: Colors.black54,
                        ),
                        title: Text(
                          'Doctor\'s Report',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          // color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => onTapActions(context),

                    // Navigator.push(context, MaterialPageRoute(builder: (_) => profileScreen()));

                    child: Card(
                      // color: Colors.white70,
                      margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: const ListTile(
                        leading: Icon(Icons.logout_outlined),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // GestureDetector(
                  //   // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => profileScreen())),
                  //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen())),

                  //   child: Card(
                  //     margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                  //     // color: Colors.white70,
                  //     // color: Theme.of(context).brightness == Brightness.dark
                  //     //     ? Colors.black12
                  //     //     : Colors.white70,
                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  //     child: const ListTile(
                  //       leading: Icon(
                  //         LineIcons.atom,
                  //         // color: Colors.black54,
                  //       ),
                  //       title: Text(
                  //         '-Admin test-',
                  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //       ),
                  //       trailing: Icon(
                  //         Icons.arrow_forward_ios_outlined,
                  //         // color: Colors.black54,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
