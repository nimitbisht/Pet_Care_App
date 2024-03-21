// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'dart:ui';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pet_care/utils.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:pet_care/screens/booking/booking_form.dart';
//  import 'package:pet_care/screens/pages/booking/booking_list.dart';
// import 'package:pet_care/screens/pages/booking/booking_appointment.dart';

// class Schedule extends StatelessWidget {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     final double fem = MediaQuery.of(context).size.width / 360;

//     return Material(
//       child: FutureBuilder<QuerySnapshot>(
//       future: _firestore.collection('available_veterinarians').get(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData) {
//           return Center(child: Text('No data found.'));
//         } else {
//           final List<DocumentSnapshot> doctors = snapshot.data!.docs;

//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: MediaQuery.of(context).size.height,
//               ),
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffdaf2f7),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.fromLTRB(12 * fem, 16 * fem, 0, 11 * fem),
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             'assets/images/group-20.png',
//                             width: 51 * fem,
//                             height: 45 * fem,
//                           ),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 14*fem),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8*fem),
//                                     color: Colors.white,
//                                   ),
//                                   child: InkWell(
//                                     onTap: () {
//                                        Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => BookingList()),
//                                       );
//                                       // Show my bookings
//                                     },
//                                     child: Padding(
//                                       padding: EdgeInsets.fromLTRB(10*fem,4*fem, 10* fem, 14* fem),
//                                       child: Center(
//                                         child: Icon(Icons.calendar_today, size: 28*fem),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),


                    
//                     Container(
//                       margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 14*fem),
//                       width: double.infinity,
//                       child: Text(
//                         'Available Veterinarian',
//                         textAlign: TextAlign.center,
//                         style: SafeGoogleFont (
//                           'Hanuman',
//                           fontSize: 24*fem,
//                           fontWeight: FontWeight.w400,
//                           height: 1.4725*fem/fem,
//                           color: Color(0xff000000),
//                         ),
//                       ),
//                     ),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: doctors.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final Map<String, dynamic> details = Map<String, dynamic>.from(doctors[index].data() as Map).cast<String, dynamic>();
//                         final detail=doctors[index];
//                         final String? image = details['image'];
//                         final List<dynamic>? availableDays = details['availableDays']?.map((day) => day.toString().substring(0, 3)).toList();
//                         String available = 'N/A';

//                         if (availableDays != null && availableDays.isNotEmpty) {
//                           available = 'Yes';
//                         }
//                         final String? name = details['name'];
//                         final String? location = details['location'];

//                         return Container(
//                           margin: EdgeInsets.fromLTRB(12 * fem, 0, 17 * fem, 10 * fem),
//                           padding: EdgeInsets.fromLTRB(8 * fem, 5 * fem, 16.33 * fem, 8 * fem),
//                           decoration: BoxDecoration(
//                             color: const Color(0xffffffff),
//                             borderRadius: BorderRadius.circular(20 * fem),
//                           ),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.only(right: 16 * fem),
//                                 width: 82 * fem,
//                                 height: 86 * fem,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20 * fem),
//                                   image: image != null
//                                       ? DecorationImage(
//                                           image: NetworkImage(image),
//                                           fit: BoxFit.cover,
//                                         )
//                                       : DecorationImage(
//                                           image: AssetImage('assets/images/doctor-1-YRv.png'),
//                                           fit: BoxFit.cover,
//                                         ),
//                                 ),

//                               ),
//                               Container(
//                                  margin: EdgeInsets.fromLTRB(0*fem, 3*fem, 106.33*fem, 0*fem),
//                                 constraints: BoxConstraints(
//                                   maxWidth: 133 * fem,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text.rich(
//                                       TextSpan(
//                                         children: [
//                                           for (var day in ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'])
//                                             WidgetSpan(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Text(
//                                                   day,
//                                                   style: TextStyle(
//                                                     color: availableDays?.contains(day.replaceAll('day', '')) ?? false
//                                                       ? Colors.green
//                                                       : Colors.red,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(height: 4 * fem),
//                                     Text.rich(
//                                       TextSpan(
//                                         children: [
//                                           TextSpan(
//                                             text: 'Doctor Name: ',
//                                             style: SafeGoogleFont(
//                                               'Hanuman',
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400,
//                                               height: 1.4725 * fem / fem,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           TextSpan(
//                                             text: name ?? 'N/A',
//                                             style: SafeGoogleFont(
//                                               'Hanuman',
//                                               fontSize: 40,
//                                               fontWeight: FontWeight.w400,
//                                               height: 1.4725 * fem / fem,
//                                               color: const Color(0xff8acaca),
//                                             ),        
//                                           ),
//                                         ],
//                                       ),
//                                     ),

//                                     SizedBox(height: 4 * fem),
//                                     Text.rich(
//                                       TextSpan(
//                                         children: [
//                                           TextSpan(
//                                             text: 'Location: ',
//                                             style: SafeGoogleFont(
//                                               'Hanuman',
//                                               fontSize: 40 ,
//                                               fontWeight: FontWeight.w400,
//                                               height: 1.4725 * fem / fem,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           TextSpan(
//                                             text: location ?? 'N/A',
//                                             style: SafeGoogleFont(
//                                               'Hanuman',
//                                               fontSize: 40,
//                                               fontWeight: FontWeight.w400,
//                                               height: 1.4725 * fem / fem,
//                                               color: const Color(0xff8acaca),
//                                             ),        
//                                           ),
//                                         ],
//                                       ),
//                                     ),
                                    
//                                     // SizedBox(height: 6 * fem),
//                                     // RichText(
//                                     //   text: TextSpan(
//                                     //     text: 'Book an appointment',
//                                     //     style: SafeGoogleFont (
//                                     //       'Hanuman',
//                                     //       fontSize: 16*fem,
//                                     //       fontWeight: FontWeight.w400,
//                                     //       height: 1.4725*fem/fem,
//                                     //       color: Color(0xff8acaca),
//                                     //     ),
//                                     //     recognizer: TapGestureRecognizer()..onTap = () {},
//                                     //   ),
//                                     // ),
//                                   ],
                                  
//                                 ),
//                               ),   
//                               MouseRegion(
//                                 cursor: SystemMouseCursors.click, // Change cursor on hover
//                                 child: Container(
//                                   margin: EdgeInsets.fromLTRB(0*fem, 4*fem, 0*fem, 0*fem),
//                                   width: 7.33*fem,
//                                   height: 15.33*fem,
//                                   child: InkWell(
//                                     onTap: () {
                                      
//                                         Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => Scaffold(
//                                             body: SingleChildScrollView(
//                                               child: BookingAppointment(doctorId: detail.id),
//                                             ),
//                                           ),
//                                         ),
//                                       );

//                                       },
//                                     child: Image.asset(
//                                       'assets/images/imgarrowright-1-KGC.png',
//                                       width: 7.33*fem,
//                                       height: 15.33*fem,
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//          );
//         }
//       },
//     ),
//     );
//   }
// }