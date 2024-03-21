import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pet_care/ZOne/map.dart';
import 'package:pet_care/ZOne/information.dart';
import 'package:pet_care/ZOne/recommended.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_care/ZOne/setting.dart';

import 'package:line_icons/line_icons.dart';
import 'package:pet_care/screens/pages/shopping/shopping.dart';

import '../screens/pages/booking/booking_list.dart';
import '../screens/pages/schedule/schedule.dart';

TextStyle heading1 = GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600);
// fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF0F1641));

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

//class MainScreen extends StatelessWidget {
class _MainScreenState extends State<MainScreen> {
  // //Bottom navigation bar routes
  // int _selectedIndex = 0;
  // void _navigateBottomBar(int index)
  // {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  //
  // final List<Widget> _pages = [
  //   InformationPage(),
  //   InformationPage(),
  //   InformationPage(),
  // ];

  int _selectedIndex = 0; // initialize the selected index to 0

  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  //location permission on app homescreen
  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _selectedIndex = 0; // Initialize _selectedIndex to 0
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, do something here
      print('Location permission granted!');
    } else {
      // Permission denied, show error message
      print('Location permission denied!');
    }
  }

  DateTime timeBackPressed = DateTime.now();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return WillPopScope(
      onWillPop: () async {
        // return false;
        setState(() {
          _selectedIndex = 0;
          // Navigator.pop(context, _selectedIndex); // pop the current route on press
        });
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          // Navigator.popAndPushNamed(context,'/home_screen');
          // Navigator.of(context).pop();
          // Navigator.of(context).pushReplacementNamed('/home_screen');
          // Navigator.of(context).pushReplacement(newRoute)
          const message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 14 * textScaleFactor);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
          // backgroundColor: Color(0xFFF8FAFB),
          appBar: AppBar(
            // toolbarHeight: 0,
            // centerTitle: true,

            title: Text(
              'Hello ${user.email!.split('@')[0]}',
            ),

            backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.grey,
            iconTheme: const IconThemeData(
              color: Colors.orange,
            ),
            // backgroundColor: Colors.deepPurpleAccent,
            elevation: 0,
            // shadowColor: Colors.deepPurpleAccent,
            // leading: ,
            // actions: [],
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200),bottomRight: Radius.circular(00)),
            // ),

            // bottom: PreferredSize(
            //   preferredSize: Size.fromHeight(0),
            //   child: SizedBox(),
            // ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    '\n${user.email!.split('@')[0]}  \n\n',

                    // 'Logged in as: ${user.email!}  ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Vet Consulting',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Schedule()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Map'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MapScreen()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Blog Centre'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InformationPage()),
                    );
                  },
                ),

                ListTile(
                  title: const Text('Shop'),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   // MaterialPageRoute(builder: (context) => const PetShoppingList()),
                    // );
                  },
                ),

                ListTile(
                  title: const Text('My Bookings'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingList(
                            userId: userId,
                          ),
                        ));
                  },
                ),
                // ListTile(
                //   title: Text('Settings'),
                //   onTap: () {
                //
                //     // Handle menu item 2 tap
                //   },
                // ),
                ListTile(
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));

                    // Handle menu item 2 tap
                  },
                ),
                // Add more list items as needed
              ],
            ),
          ),
          body: SafeArea(
            //safearea vs centre

            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 0, right: 16.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        // height: getVerticalSize(134.00,),
                        // width: getHorizontalSize(468.00,),
                        // margin: getMargin(
                        //   left: 20,
                        //   top: 8,
                        //   right: 20,
                        // ),

                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    // width: getHorizontalSize(268.00,),
                                    // margin: getMargin(bottom: 2,),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "PET CARE \n",
                                            style: GoogleFonts.poppins(
                                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.deepOrangeAccent,
                                              fontSize: (45 * textScaleFactor),

                                              // fontFamily: 'SF UI Display',
                                              fontWeight: FontWeight.w300,
                                              // fontWeight: FontWeight.w500,
                                              height: 2.12,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "To give them the care they NEED !",
                                            style: TextStyle(
                                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                              fontSize: (15 * textScaleFactor),
                                              // fontFamily: 'SF UI Display',
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w500,
                                              // fontWeight: FontWeight.w500,

                                              height: 1.32,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 1.0, top: 0, right: 1.0),
                                      child: Image.asset(
                                        'assets/images/dog2.gif',
                                        width: 120,
                                        height: 120,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 56.0),
                    LabelSection(
                      text: 'Pet Services',

                      // style: heading1
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black54,
                        fontSize: (25),
                        // fontFamily: 'SF UI Display',
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                        // fontWeight: FontWeight.w500,

                        // height: 1.32,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Recommended(),
                    const SizedBox(height: 56.0),
                    LabelSection(
                      text: 'Shop by Category',
                      //
                      // style: GoogleFonts.poppins(
                      // color: Theme.of(context).brightness == Brightness.dark
                      //     ? Colors.white
                      //     : Color(0xFF0F1641),
                      // fontSize: (18),
                      // // fontFamily: 'GoogleFonts.poppins',
                      // fontWeight: FontWeight.w600,
                      // // fontWeight: FontWeight.w500,
                      // height: 1.32,),
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black54,
                        fontSize: (25),
                        // fontFamily: 'SF UI Display',
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                        // fontWeight: FontWeight.w500,

                        // height: 1.32,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Top(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: GNav(
              selectedIndex: _selectedIndex,
              gap: 8,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              activeColor: Colors.deepOrange,
              // tabBackgroundColor: Colors.grey,
              iconSize: 25,
              duration: const Duration(milliseconds: 400),
              // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 32),
              // tabBackgroundColor: Colors.grey[100]!,
              // color: Colors.black,

              onTabChange: (index) {
                // print(index);

                setState(() {
                  _selectedIndex = index; // update the selected index
                });
                // navigate to different pages based on the selected index
                switch (index) {
                  case 0:
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
                    break;
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingList(
                            userId: userId,
                          ),
                        ));
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => Medical()));
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Shopping(),
                      ),
                    );

                    break;
                  case 3:
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsPage(),
                      ),
                    );
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
                  text: 'Schedule',
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
