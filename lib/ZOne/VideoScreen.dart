// import 'package:flutter/material.dart';
// import 'package:pet_care/screens/home/home_screen1.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../Auth/authentication.dart';
//
//
// class VideoScreen extends StatefulWidget {
//   const VideoScreen ({super.key});
//
//
//   @override
//   State<VideoScreen> createState() => _VideoScreen();
// }
// // String a = '1234';
//
// class _VideoScreen extends State<VideoScreen> {
//   final user = FirebaseAuth.instance.currentUser!;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:SafeArea(
//         child: ZegoUIKitPrebuiltCall(
//           appID: 1946239155,
//           appSign: '947355e9a5e925d0a4c3cae498e108927d2ce84b96379e4fc05e49e94b06ca5c',
//           callID: '54321',      //same to connect users
//           config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
//           userID: user.uid,     //user1,2
//           userName: user.email!,     //user1,2
//
//
//         ),
//       ),
//     );
//
//
//   }
// }