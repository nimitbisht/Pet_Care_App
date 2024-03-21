import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BookingDetailScreen extends StatelessWidget {
  final String bookingId;
  const BookingDetailScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('bookings').doc(bookingId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      
          final bookingData = snapshot.data!.data()!;
      
          String? startTimeString = bookingData['startTime'];
          String? endTimeString = bookingData['endTime'];
      
          DateTime? startTime;
          if (startTimeString != null) {
            DateFormat format = DateFormat('h:mm a');
            startTime = format.parse(startTimeString);
          }
      
          DateTime? endTime;
          if (endTimeString != null) {
            DateFormat format = DateFormat('h:mm a');
            endTime = format.parse(endTimeString);
          }
      
          // Calculate the duration between the start and end times
          Duration? duration;
          if (startTime != null && endTime != null) {
            duration = endTime.difference(startTime);
          }
          String durationString = duration != null ? duration.inMinutes.toString() : 'N/A';
      
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildBookingDetailRow('Pet Name:', bookingData['petName'] ?? 'N/A'),
                          _buildBookingDetailRow('Owner Name:', bookingData['ownerName'] ?? 'N/A'),
                          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            future: FirebaseFirestore.instance.collection('available_veterinarians').doc(bookingData['doctorId']).get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final doctorData = snapshot.data!.data();
                                String doctorName = doctorData?['name'] ?? 'N/A';
                                String registeredNumber = doctorData?['registered_number'] ?? 'N/A';
          
                                return Column(
                                  children: [
                                    _buildBookingDetailRow('Doctor Name:', doctorName),
                                    _buildBookingDetailRow('Doctor Registered Number:', registeredNumber),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return const Text('Error fetching doctor details');
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          _buildBookingDetailRow('Date:', bookingData['date'] ?? 'N/A'),
                          _buildBookingDetailRow('Time:', bookingData['startTime'] ?? 'N/A'),
                          _buildBookingDetailRow('Duration:', durationString ?? 'N/A'),
                          _buildBookingDetailRow('Address:', bookingData['address'] ?? 'N/A'),
                          _buildBookingDetailRow('Notes:', bookingData['notes'] ?? 'N/A'),
                          _buildBookingDetailRow('Status:', bookingData['status'] ?? 'N/A'),
                          _buildBookingDetailRow('Appointment Type:', bookingData['appointmentType'] ?? 'N/A'),
                          _buildBookingDetailRow('Contact Info:', bookingData['contactInfo'] ?? 'N/A'),
                          _buildBookingDetailRow('Reason for Visit:', bookingData['reasonForVisit'] ?? 'N/A'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBookingDetailRow(String label, String? value) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? '',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setState(Null Function() param0) {}
}
