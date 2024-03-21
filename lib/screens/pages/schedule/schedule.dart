import 'package:flutter/material.dart';

import 'package:pet_care/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pet_care/screens/booking/booking_form.dart';
import 'package:pet_care/screens/pages/booking/booking_list.dart';
import 'package:pet_care/screens/pages/booking/booking_appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../ZOne/homescreen.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  _ScheduleState createState() => _ScheduleState();
}

int _selectedIndex = 0; // initialize the selected index to 0
final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

class _ScheduleState extends State<Schedule> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String locationFilter = 'All';
  List<String> locationOptions = [];
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  @override
  Widget build(BuildContext context) {
    final double fem = MediaQuery.of(context).size.width / 360;

    return Material(
      child: FutureBuilder<QuerySnapshot>(
        future: _firestore.collection('available_veterinarians').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found.'));
          } else {
            final List<QueryDocumentSnapshot> doctors = snapshot.data!.docs;
            List<QueryDocumentSnapshot> filteredDoctors;
            final Set<String> uniqueLocations = <String>{};
            doctors.retainWhere(
              (doctor) {
                final Map<String, dynamic> doctorData = doctor.data() as Map<String, dynamic>;
                return doctorData['is_verified'] == true;
              },
            );
            for (var doctor in doctors) {
              final Map<String, dynamic> doctorData = doctor.data() as Map<String, dynamic>;
              final String? location = doctorData['location'];
              if (location != null) {
                uniqueLocations.add(location);
              }
            }
            List<String> locationOptions = uniqueLocations.toList();

            locationOptions.insert(0, 'All');
            locationOptions.sort((a, b) => a.compareTo(b));

            if (locationFilter == 'All') {
              filteredDoctors = doctors;
            } else if (uniqueLocations.contains(locationFilter)) {
              filteredDoctors = doctors.where((doctor) {
                final doctorData = doctor.data() as Map<String, dynamic>?;
                final doctorLocation = doctorData?['location'] as String?;
                return doctorLocation == locationFilter;
              }).toList();
            } else {
              filteredDoctors = [];
            }

            return Scaffold(
              backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white70,
              appBar: AppBar(
                backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
                title: const Text(
                  'Schedule Appointment',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingList(
                              userId: userId,
                            ),
                          ),
                        );
                        // Show my bookings
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 15),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(10 * fem, 0 * fem, 0 * fem, 14 * fem),
                        //   width: double.infinity,
                        //   child: Text(
                        //     'Available Veterinarian',
                        //     textAlign: TextAlign.left,
                        //     style: SafeGoogleFont(
                        //       'Hanuman',
                        //       fontSize: 20 * fem,
                        //       fontWeight: FontWeight.w400,
                        //       height: 1.4725 * fem / fem,
                        //       color: const Color(0xff000000),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8 * fem, horizontal: 16 * fem),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Handle the dropdown menu tap action
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff8acaca)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16 * fem),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Filters',
                                  style: SafeGoogleFont(
                                    'Hanuman',
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4725 * fem / fem,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8 * fem),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: locationFilter,
                                  onChanged: (newValue) {
                                    setState(() {
                                      locationFilter = newValue!;
                                    });
                                  },
                                  items: locationOptions.map<DropdownMenuItem<String>>((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: SafeGoogleFont(
                                          'Hanuman',
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.4725 * fem / fem,
                                          color: locationFilter == option ? Colors.grey : Colors.grey.shade400,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  alignment: AlignmentDirectional.center,
                                  style: const TextStyle(color: Colors.black),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconEnabledColor: const Color.fromARGB(255, 70, 206, 126),
                                  iconSize: 28 * fem,
                                  dropdownColor: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Text(
                            "Search result for: '$locationFilter'",
                            style: SafeGoogleFont(
                              'Hanuman',
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                              height: 1.4725 * fem / fem,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: filteredDoctors.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Map<String, dynamic> details = (filteredDoctors[index].data() as Map<String, dynamic>).cast<String, dynamic>();
                            final detail = filteredDoctors[index];
                            final String? image = details['image'];
                            final String? name = details['name'];
                            final String? geolocation = details['geolocation'];
                            final String? registeredNumber = details['registered_number'];
                            return Container(
                              margin: EdgeInsets.only(bottom: 10 * fem, left: 10 * fem, right: 10 * fem),
                              padding: EdgeInsets.all(12 * fem),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white60,
                                borderRadius: BorderRadius.circular(20 * fem),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8 * fem,
                                    spreadRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 16 * fem),
                                    width: 82 * fem,
                                    height: 86 * fem,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20 * fem),
                                      image: image != null
                                          ? DecorationImage(
                                              image: NetworkImage(image),
                                              fit: BoxFit.cover,
                                            )
                                          : const DecorationImage(
                                              image: AssetImage('assets/images/doctor-1-YRv.png'),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (registeredNumber != null)
                                          // Registration Number
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade600 : Colors.white38,
                                              borderRadius: BorderRadius.circular(10 * fem),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.2),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              'Registered Number: $registeredNumber',
                                              style: SafeGoogleFont(
                                                'Hanuman',
                                                fontSize: 12 * fem,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        SizedBox(height: 8 * fem),
                                        //Doctor Name
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Doctor Name: ',
                                                style: SafeGoogleFont(
                                                  'Hanuman',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.4725 * fem / fem,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: name ?? 'N/A',
                                                style: SafeGoogleFont(
                                                  'Hanuman',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.4725 * fem / fem,
                                                  color: Theme.of(context).brightness == Brightness.dark ? const Color(0xff8acaca) : Colors.grey.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4 * fem),
                                        // Location
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Location: ',
                                                style: SafeGoogleFont(
                                                  'Hanuman',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.4725 * fem / fem,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: geolocation ?? 'N/A',
                                                style: SafeGoogleFont(
                                                  'Hanuman',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.4725 * fem / fem,
                                                  color: Theme.of(context).brightness == Brightness.dark ? const Color(0xff8acaca) : Colors.grey.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 12 * fem),
                                        Container(
                                          alignment: Alignment.bottomRight,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Scaffold(
                                                    body: BookingAppointment(doctorId: detail.id),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 120,
                                              height: 40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue.shade300,
                                                borderRadius: BorderRadius.circular(14 * fem),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.2),
                                                    blurRadius: 10 * fem,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                'Book Now',
                                                style: SafeGoogleFont(
                                                  'Hanuman',
                                                  fontSize: 12 * fem,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
