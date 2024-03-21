import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pet_care/ZOne/homescreen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pet_care/screens/login/login_screen.dart';
import '../../Auth/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/home/home_screen1.dart';
import '../screens/home/profileScreen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 3; // initialize the selected index to 0
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
          // backgroundColor: Theme.of(context).brightness == Brightness.dark
          //     ? Colors.black
          //     : Colors.white,
          appBar: AppBar(
            centerTitle: true,
            // iconTheme: IconThemeData(
            //   color: Colors.black, // set the color of the icon
            //   size: 20, // set the size of the icon
            // ),
            automaticallyImplyLeading: false,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back_ios_new), // set your desired icon
            //   onPressed: () {
            //     Navigator.pop(context); // pop the current route on press
            //   },
            // ),

            title: const Text.rich(
              TextSpan(
                style: TextStyle(),
                children: [
                  TextSpan(
                    text: 'Settings',
                    style: TextStyle(
                      fontSize: 27,
                      fontFamily: 'Quicksand',
                      // fontFamily: 'Spartan MB',
                      // color: Colors.black87,
                      fontWeight: FontWeight.w900,
                      height: 2,
                    ),
                  ),

                  // WidgetSpan(
                  //   child: Image.asset(
                  //     'assets/images/map2.gif',
                  //     width: 50,
                  //     height: 50,
                  //   ),
                  // ),

                  // WidgetSpan(
                  //   child: Icon(Icons.public ,
                  //     color: Colors.green,
                  //     size: 39.0,
                  //   ),
                  // ),
                ],
              ),
            ), //title

            backgroundColor: Colors.deepPurpleAccent, //background color of app bar

            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(00)),
            // ),

            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: SizedBox(),
            ),
          ),
          body: Container(
            // color: Colors.white54,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                // const ListTile(
                //   leading: Icon(Icons.arrow_back),
                //   trailing: Icon(Icons.menu),
                // ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "",
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                    )
                  ],
                ),
                Container(
                  child: Expanded(
                      child: ListView(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),

                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => profileScreen(),
                          ),
                        ),
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
                        onTap: () {
                          Geolocator.openAppSettings();
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
                      // const SizedBox(
                      //   height: 10,
                      // ),

                      GestureDetector(
                        onTap: () {
                          Geolocator.openLocationSettings();
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
                              LineIcons.locationArrow,
                              // Icons.privacy_tip_sharp,
                              // color: Colors.black54,
                            ),
                            title: Text(
                              'Location',
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
                        onTap: () => onTapActions(context),

                        // Navigator.push(context, MaterialPageRoute(builder: (_) => profileScreen()));

                        child: Card(
                          // color: Colors.white70,
                          margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(Icons.logout_outlined, color: Colors.redAccent),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_outlined, color: Colors.redAccent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      const SizedBox(
                        height: 30,
                      ),

                      GestureDetector(
                        // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => profileScreen())),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen())),

                        child: Card(
                          margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                          // color: Colors.white70,
                          // color: Theme.of(context).brightness == Brightness.dark
                          //     ? Colors.black12
                          //     : Colors.white70,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(
                              LineIcons.atom,
                              // color: Colors.black54,
                            ),
                            title: Text(
                              '-Admin test-',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              // color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                )
              ],
            ),
          ),
          bottomNavigationBar: GNav(
              selectedIndex: _selectedIndex,
              gap: 0,
              rippleColor: Colors.grey[300]!,
              activeColor: Colors.deepPurpleAccent,
              // tabBackgroundColor: Colors.grey,
              // iconSize: 24,
              duration: const Duration(milliseconds: 400),
              // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 25,
              ),
              onTabChange: (index) {
                // print(index);

                setState(() {
                  _selectedIndex = index; // update the selected index
                });
                // navigate to different pages based on the selected index
                switch (index) {
                  case 0:
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));

                    break;
                  case 1:

                    // Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                    break;
                  case 2:
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => profileScreen()));
                    break;
                  case 3:
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage()));
                    break;
                }
              },
              // tabBackgroundColor: Colors.purpleAccent,
              tabs: const [
                // GButton(icon: Icons.home,
                //   text: 'Home',
                // ),
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.calendarCheckAlt,
                  text: 'Records',
                ),
                GButton(
                  icon: LineIcons.addToShoppingCart,
                  text: 'Cart',
                ),
                GButton(
                  icon: LineIcons.tools,
                  text: 'Settings',
                ),
              ])),
    );
  }
}
