import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'ZOne/homescreen.dart';


void main() async {

  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark,
  //   ),
  // );

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override

  // final Map<String, WidgetBuilder> routes = {
  //   '/': (context) => MainScreen(),
  //   '/screen1': (context) => InformationPage(),
  //   '/screen2': (context) => MapScreen(),
  // };

  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      title: 'Petcare App',

      // initialRoute: '/',
      // routes: {
      //   '/': (context) => MainScreen(),
      //   '/page1': (context) => Example(),
      //   '/page2': (context) => MainScreen(),
      // },






      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.system,
      //home: MainScreen(),
      // Set the initial route to the home screen
      // initialRoute: '/',
      // Set the routes
      // routes: routes,


      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
