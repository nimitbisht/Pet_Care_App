import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditBookingForm extends StatefulWidget {
  final String bookingId;

  const EditBookingForm({super.key, required this.bookingId});

  @override
  _EditBookingFormState createState() => _EditBookingFormState();
}

class _EditBookingFormState extends State<EditBookingForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _petNameController;
  late TextEditingController _ownerNameController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _petNameController = TextEditingController();
    _ownerNameController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    _statusController = TextEditingController();

    // Fetch booking document from Firestore and populate form fields
    FirebaseFirestore.instance
        .collection('bookings')
        .doc(widget.bookingId)
        .get()
        .then((doc) {
      if (doc.exists) {
        _petNameController.text = doc['petName'];
        _ownerNameController.text = doc['ownerName'];
        _dateController.text = doc['date'];
        _timeController.text = doc['time'];
        _statusController.text = doc['status'];
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  void dispose() {
    _petNameController.dispose();
    _ownerNameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _petNameController,
                decoration: const InputDecoration(
                  labelText: 'Pet Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the pet name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _ownerNameController,
                decoration: const InputDecoration(
                  labelText: 'Owner Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the owner name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(
                  labelText: 'Status',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Update booking document in Firestore
                    FirebaseFirestore.instance
                        .collection('bookings')
                        .doc(widget.bookingId)
                        .update({
                      'petName': _petNameController.text,
                      'ownerName': _ownerNameController.text,
                      'date': _dateController.text,
                      'time': _timeController.text,
                      'status': _statusController.text,
                    }).then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
