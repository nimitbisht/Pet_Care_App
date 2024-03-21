import 'package:flutter/material.dart';
import 'booking_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AddBookingForm extends StatefulWidget {
  final String doctorId;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const AddBookingForm({
    super.key,
    required this.doctorId,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  @override
  _AddBookingFormState createState() => _AddBookingFormState();
}

class _AddBookingFormState extends State<AddBookingForm> {
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  final _formKey = GlobalKey<FormState>();

  TextEditingController petNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController appointmentTypeController = TextEditingController();
  TextEditingController contactInfoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Add Booking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Pet Name',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter pet name';
                    }
                    return null;
                  },
                  controller: petNameController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Owner Name',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter owner name';
                    }
                    return null;
                  },
                  controller: ownerNameController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Note',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Note';
                    }
                    return null;
                  },
                  controller: appointmentTypeController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contact Information',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter contact information';
                    } else if (value.length != 10) {
                      return 'Contact information must be 10 digits';
                    }
                    return null;
                  },
                  controller: contactInfoController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numbers
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the address';
                    }
                    return null;
                  },
                  controller: addressController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseFirestore.instance.collection('bookings').add({
                          'doctorId': widget.doctorId,
                          'userId': userId,
                          'petName': petNameController.text,
                          'ownerName': ownerNameController.text,
                          'date': widget.date.toString().substring(0, 10),
                          'startTime': widget.startTime.format(context),
                          'endTime': widget.endTime.format(context),
                          'status': "Pending",
                          'notes': appointmentTypeController.text,
                          'contactInfo': contactInfoController.text,
                          'address': addressController.text,
                        }).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking added successfully'),
                            ),
                          );
                          petNameController.clear();
                          ownerNameController.clear();
                          dateController.clear();
                          timeController.clear();
                          appointmentTypeController.clear();
                          contactInfoController.clear();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingList(
                                userId: userId,
                              ),
                            ),
                          );
                          // ignore: invalid_return_type_for_catch_error
                        }).catchError((error) => debugPrint('Failed to add booking: $error'));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
