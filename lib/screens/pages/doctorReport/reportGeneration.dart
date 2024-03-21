import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorDataScreen extends StatefulWidget {
  const DoctorDataScreen({super.key});

  @override
  _DoctorDataScreenState createState() => _DoctorDataScreenState();
}

class _DoctorDataScreenState extends State<DoctorDataScreen> {
  List<Map<String, dynamic>> doctorDataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getDoctorData();
  }

  void getDoctorData() async {
    setState(() {
      isLoading = true;
    });

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('available_veterinarians').get();

    List<Map<String, dynamic>> dataList = [];

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      String doctorId = doc.id;
      String doctorName = doc['name'];
      bool isVerified = doc['is_verified'] ?? false;
      String registeredNumber = doc['registered_number']; // New field

      int? numPendingBookings = await getNumBookings(doctorId, 'Pending');
      int? numCompletedBookings = await getNumBookings(doctorId, 'Completed');

      Map<String, dynamic> doctorData = {
        'doctorId': doctorId,
        'name': doctorName,
        'registeredNumber': registeredNumber, // Add the field to the map
        'numPendingBookings': numPendingBookings,
        'numCompletedBookings': numCompletedBookings,
        'isVerified': isVerified,
      };

      dataList.add(doctorData);
    }

    setState(() {
      doctorDataList = dataList;
      isLoading = false;
    });
  }

  Future<int?> getNumBookings(String doctorId, String status) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bookings').where('doctorId', isEqualTo: doctorId).where('status', isEqualTo: status).get();

    return snapshot.size;
  }

  Future<List<Map<String, dynamic>>> getBookingsByDoctorId(String doctorId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bookings').where('doctorId', isEqualTo: doctorId).get();

    List<Map<String, dynamic>> bookings = [];
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      String ownerName = doc['ownerName'];
      String status = doc['status'];
      String date = doc['date'];
      String startTime = doc['startTime'];
      String endTime = doc['endTime'];

      Map<String, dynamic> bookingData = {
        'ownerName': ownerName,
        'status': status,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
      };

      bookings.add(bookingData);
    }
    return bookings;
  }

  void viewPetOwners(String doctorId, String doctorName) async {
    List<Map<String, dynamic>> bookings = await getBookingsByDoctorId(doctorId);

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PetOwnersScreen(doctorName: doctorName, bookings: bookings),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Doctor\'s report'),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white60,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Show the loading indicator
            )
          : ListView.builder(
              itemCount: doctorDataList.length,
              itemBuilder: (context, index) {
                String doctorId = doctorDataList[index]['doctorId'];
                String doctorName = doctorDataList[index]['name'];
                int? numPendingBookings = doctorDataList[index]['numPendingBookings'];
                int? numCompletedBookings = doctorDataList[index]['numCompletedBookings'];
                bool isVerified = doctorDataList[index]['isVerified'];
                String registeredNumber = doctorDataList[index]['registeredNumber'];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
                  child: ListTile(
                    title: Text(
                      doctorName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pending Bookings: ${numPendingBookings ?? 'N/A'}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Completed Bookings: ${numCompletedBookings ?? 'N/A'}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Verified: ${isVerified ? 'Yes' : 'No'}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Registered Number: $registeredNumber',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
                    ),
                    onTap: () {
                      viewPetOwners(doctorId, doctorName);
                    },
                  ),
                );
              },
            ),
    );
  }
}

class PetOwnersScreen extends StatelessWidget {
  final String doctorName;
  final List<Map<String, dynamic>> bookings;

  const PetOwnersScreen({super.key, required this.doctorName, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          doctorName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white,
      body: Column(
        children: [
          if (bookings.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  // String petName = bookings[index]['petName'] ?? '';
                  String ownerName = bookings[index]['ownerName'] ?? '';
                  String status = bookings[index]['status'] ?? '';
                  String date = bookings[index]['date'] ?? '';
                  String startTime = bookings[index]['startTime'] ?? '';
                  String endTime = bookings[index]['endTime'] ?? '';

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    elevation: 6,
                    child: ListTile(
                      title: Text(
                        ownerName,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status: $status'),
                          if (date.isNotEmpty) Text('Booking Date: $date'),
                          Text('Start Time: $startTime'),
                          Text('End Time: $endTime'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          if (bookings.isEmpty)
            Container(
              alignment: Alignment.center,
              child: const Text(
                'No bookings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
