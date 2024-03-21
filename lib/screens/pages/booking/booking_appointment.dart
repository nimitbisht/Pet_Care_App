import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/screens/pages/booking/review.dart';
import '../../../components/review_list.dart';
import 'new_appointment_date.dart';

class BookingAppointment extends StatefulWidget {
  final String doctorId;

  const BookingAppointment({super.key, required this.doctorId});

  @override
  _BookingAppointmentState createState() => _BookingAppointmentState();
}

class _BookingAppointmentState extends State<BookingAppointment> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white70,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Booking Appointment'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('available_veterinarians').doc(widget.doctorId).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final doctorData = snapshot.data?.data() as Map<String, dynamic>?;

            if (doctorData == null) {
              return const Text('Doctor not found.');
            }

            return Container(
              // padding: EdgeInsets.fromLTRB(0 * fem, 18 * fem, 0 * fem, 0 * fem),
              width: double.infinity,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      // Image
                      Container(
                        padding: EdgeInsets.only(
                          top: 10 * fem,
                          right: 10 * fem,
                          left: 10 * fem,
                        ),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20 * fem),
                          child: Image.asset(
                            'assets/images/doctor-1-Rc4.png',
                            height: 250 * fem,
                            width: 250 * fem,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30 * fem), topRight: Radius.circular(30 * fem)),
                          color: Theme.of(context).brightness == Brightness.dark ? const Color.fromARGB(255, 54, 53, 53) : const Color(0xffffffff),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20 * fem),
                            Padding(
                              padding: EdgeInsets.only(left: 15 * fem, bottom: fem, right: 10 * fem, top: 0 * fem),
                              child: Text(
                                '${doctorData['name'] ?? 'N.A'}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15 * fem, bottom: 0, right: 10 * fem, top: 0),
                              child: Text(
                                '${doctorData['location'] ?? 'N.A'}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                            SizedBox(height: 10 * fem),
                            Padding(
                              padding: EdgeInsets.only(left: 15 * fem, bottom: 0, right: 10 * fem, top: 0),
                              child: Row(
                                children: [
                                  Text(
                                    'Registered Number:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10 * fem),
                                  Text(
                                    '${doctorData['registered_number'] ?? 'N.A'}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10 * fem),
                            // Reviews -- Moksh Upadhyay
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12 * fem, horizontal: 12 * fem),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Reviews",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.star, color: Colors.amber, size: 20),
                                      const SizedBox(width: 5),
                                      const Text(
                                        "4.1",
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "(125)",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                      const SizedBox(width: 135),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Review(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue.shade400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //Reviews
                            const SizedBox(
                              height: 160,
                              child: ReviewList(),
                            ),
                            // Consultation fee
                            Padding(
                              padding: EdgeInsets.only(left: 15 * fem, right: 15, top: 10 * fem),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Consultation Fee",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Rs ${doctorData['fee']}.00',
                                    style: TextStyle(
                                      color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // 'Book Now' Button
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookingAppointment1(doctorId: widget.doctorId),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
                                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                      textStyle: const TextStyle(fontSize: 18.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                    ),
                                    child: const Text(
                                      'Book Now',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
