// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCU6BfEre80LHpO7LkMHi4Ne0nHV0SrEx8',
    appId: '1:825699678021:web:28cb96cc2ce3c43876302c',
    messagingSenderId: '825699678021',
    projectId: 'petcareproject-b6eb5',
    authDomain: 'petcareproject-b6eb5.firebaseapp.com',
    storageBucket: 'petcareproject-b6eb5.appspot.com',
    measurementId: 'G-1L89CYVR2Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'API KEY',
    appId: '1:825699678021:android:3a070bb5dae5847e76302c',
    messagingSenderId: '825699678021',
    projectId: 'petcareproject-b6eb5',
    storageBucket: 'petcareproject-b6eb5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCabmQ-fbkOMEXh9xN7veqSD1lEDKeG6ao',
    appId: '1:825699678021:ios:2132f90f4fe09af376302c',
    messagingSenderId: '825699678021',
    projectId: 'petcareproject-b6eb5',
    storageBucket: 'petcareproject-b6eb5.appspot.com',
    androidClientId: '825699678021-qbfj42gea3n1ldlpoaiv03lhq2sc8ha3.apps.googleusercontent.com',
    iosClientId: '825699678021-99fburrfuuv7me68cqiiuumh75oa9iva.apps.googleusercontent.com',
    iosBundleId: 'com.example.petCare',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCabmQ-fbkOMEXh9xN7veqSD1lEDKeG6ao',
    appId: '1:825699678021:ios:2132f90f4fe09af376302c',
    messagingSenderId: '825699678021',
    projectId: 'petcareproject-b6eb5',
    storageBucket: 'petcareproject-b6eb5.appspot.com',
    androidClientId: '825699678021-qbfj42gea3n1ldlpoaiv03lhq2sc8ha3.apps.googleusercontent.com',
    iosClientId: '825699678021-99fburrfuuv7me68cqiiuumh75oa9iva.apps.googleusercontent.com',
    iosBundleId: 'com.example.petCare',
  );
}
