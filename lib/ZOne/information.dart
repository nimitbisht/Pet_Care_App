import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//custom bar for information
class CustomAppBar extends StatelessWidget {
  AnimationController animationController;
  Animation colorsTween, homeTween, yTween, iconTween, drawerTween;
  Function()? onPressed;

  CustomAppBar({super.key, required this.animationController, required this.colorsTween, required this.drawerTween, required this.homeTween, required this.iconTween, required this.onPressed, required this.yTween});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20.0,
                color: drawerTween.value,
              ),
              onPressed: () {
                Navigator.pop(context); // pop current screen
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
            backgroundColor: colorsTween.value,
            title: Row(
              children: [
                Text(
                  "Blog ",
                  style: TextStyle(color: homeTween.value, fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Text(
                  "Centre",
                  style: TextStyle(
                    color: yTween.value,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  // ignore: non_constant_identifier_names
  late Animation _colorTween, _InformationPageTween, _yTween, _iconTween, _drawerTween;
  late AnimationController _textAnimationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white70).animate(_animationController);
    _iconTween = ColorTween(begin: Colors.white, end: Colors.lightBlue).animate(_animationController);
    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black).animate(_animationController);
    _InformationPageTween = ColorTween(begin: Colors.white, end: Colors.blue).animate(_animationController);
    _yTween = ColorTween(begin: Colors.white, end: Colors.black).animate(_animationController);
    _textAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 0));
    super.initState();
  }

  bool scrollListner(ScrollNotification scrollNotification) {
    bool scroll = false;
    if (scrollNotification.metrics.axis == Axis.vertical) {
      _animationController.animateTo(scrollNotification.metrics.pixels / 80);
      _textAnimationController.animateTo(scrollNotification.metrics.pixels);
      return scroll = true;
    }
    return scroll;
  }

  int _selectedIndex = 0; // initialize the selected index to 0

  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // drawer: Drawer(),
      // backgroundColor: Colors.white,
      body: NotificationListener(
        onNotification: scrollListner,
        child: Stack(
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
                            decoration: const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.only(bottomRight: Radius.circular(0), bottomLeft: Radius.circular(0))),
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    width: MediaQuery.of(context).size.width,
                                    child: const Text(
                                      "Stay up-to-date with the latest pet news, tips, and stories.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Quicksand',
                                      ),
                                    )),
                                InkWell(
                                  onTap: () async {
                                    if (await canLaunch('https://resources.bestfriends.org/pet-health/dogs-health')) {
                                      await launch(
                                        'https://resources.bestfriends.org/pet-health/dogs-health',
                                        forceSafariVC: true,
                                        forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch';
                                    }
                                  },
                                  onLongPress: () async {
                                    if (await canLaunch('https://resources.bestfriends.org/pet-health/dogs-health')) {
                                      await launch(
                                        'https://resources.bestfriends.org/pet-health/dogs-health',
                                        forceSafariVC: true,
                                        // forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch';
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 170,
                                          decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/blog1.png"))),
                                        ),
                                        Container(
                                          height: 170,
                                          color: Colors.black26,
                                        ),
                                        const Positioned(
                                          right: 20,
                                          left: 10,
                                          top: 5,
                                          child: Text(
                                            "Pet Health",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                // fontFamily: 'Quicksand',
                                                // fontFamily: 'Spartan MB',
                                                fontSize: 22),
                                          ),
                                        ),
                                        const Positioned(
                                          right: 30,
                                          left: 12,
                                          top: 148,
                                          child: Text(
                                            "Provides resources related to dog health and care.",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (await canLaunch('https://www.thewildest.com/')) {
                                      await launch(
                                        'https://www.thewildest.com/',
                                        forceSafariVC: true,
                                        forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch';
                                    }
                                  },
                                  onLongPress: () async {
                                    if (await canLaunch('https://www.thewildest.com/')) {
                                      await launch(
                                        'https://www.thewildest.com/',
                                        forceSafariVC: true,
                                        // forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch';
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 170,
                                          decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/images/blog2.png"))),
                                        ),
                                        Container(
                                          height: 170,
                                          color: Colors.black26,
                                        ),
                                        const Positioned(
                                          right: 20,
                                          left: 10,
                                          top: 7,
                                          child: Text(
                                            "The Wildest",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                                          ),
                                        ),
                                        const Positioned(
                                          right: 15,
                                          left: 10,
                                          top: 133,
                                          child: Text(
                                            "The destination that helps you keep your cool in the wild world of pet parenting.",
                                            style: TextStyle(color: Colors.white, fontFamily: 'Quicksand', fontWeight: FontWeight.w600, fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (await canLaunch('https://www.rover.com/blog/')) {
                                      await launch(
                                        'https://www.rover.com/blog/',
                                        forceSafariVC: true,
                                        forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch';
                                    }
                                  },
                                  onLongPress: () async {
                                    if (await canLaunch('https://www.rover.com/blog/')) {
                                      await launch(
                                        'https://www.rover.com/blog/',
                                        forceSafariVC: true,
                                        // forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch';
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 170,
                                          decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/blog3.jpg"))),
                                        ),
                                        Container(
                                          height: 170,
                                          color: Colors.black26,
                                        ),
                                        const Positioned(
                                          right: 20,
                                          left: 10,
                                          top: 5,
                                          child: Text(
                                            "The Dog People",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                                          ),
                                        ),
                                        const Positioned(
                                          right: 10,
                                          left: 20,
                                          top: 130,
                                          child: Text(
                                            "pet-related articles, tips, and advice on dog care, behavior, training, health, and lifestyle.",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Quicksand', fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (await canLaunch('https://www.purina.com/articles/puppy')) {
                                      await launch(
                                        'https://www.purina.com/articles/puppy/',
                                        forceSafariVC: true,
                                        forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch';
                                    }
                                  },
                                  onLongPress: () async {
                                    if (await canLaunch('https://www.purina.com/articles/puppy')) {
                                      await launch(
                                        'https://www.purina.com/articles/puppy',
                                        forceSafariVC: true,
                                        // forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch';
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 170,
                                          decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/blog4.png"))),
                                        ),
                                        Container(
                                          height: 170,
                                          color: Colors.black26,
                                        ),
                                        const Positioned(
                                          right: 20,
                                          left: 10,
                                          top: 10,
                                          child: Text(
                                            "Purina",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                                          ),
                                        ),
                                        const Positioned(
                                          right: 10,
                                          left: 12,
                                          top: 118,
                                          child: Text(
                                            "Collection of articles and resources to help new puppy owners with the care, training, and development of their furry friends.",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Quicksand', fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (await canLaunch('https://www.cesarsway.com/')) {
                                      await launch(
                                        'https://www.cesarsway.com/',
                                        forceSafariVC: true,
                                        forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch';
                                    }
                                  },
                                  onLongPress: () async {
                                    if (await canLaunch('https://www.cesarsway.com/')) {
                                      await launch(
                                        'https://www.cesarsway.com/',
                                        forceSafariVC: true,
                                        // forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch';
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 170,
                                          decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/blog5.png"))),
                                        ),
                                        Container(
                                          height: 170,
                                          color: Colors.black26,
                                        ),
                                        const Positioned(
                                          right: 20,
                                          left: 10,
                                          top: 10,
                                          child: Text(
                                            "Cesar's Way",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                                          ),
                                        ),
                                        const Positioned(
                                          right: 10,
                                          left: 12,
                                          top: 148,
                                          child: Text(
                                            "Articles,tips and advice on dog behavior and training.",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Quicksand', fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CustomAppBar(animationController: _animationController, colorsTween: _colorTween, drawerTween: _drawerTween, homeTween: _InformationPageTween, iconTween: _iconTween, onPressed: () {}, yTween: _yTween)
              ],
            )
          ],
        ),
      ),
    );
  }
}
