import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class AddVetForm extends StatefulWidget {
  const AddVetForm({super.key});

  @override
  _AddVetFormState createState() => _AddVetFormState();
}

class _AddVetFormState extends State<AddVetForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? specialization;
  String? phone;
  String? email;
  GeoPoint? geolocation;
  
  List<String>? availableDays = [];
  List<String>? availableHours = [];
  final List<String> daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  final List<String> hoursOfDay = [    '9:00 AM - 12:00 PM',    '1:00 PM - 4:00 PM',    '5:00 PM - 8:00 PM',    '9:00 PM - 11:00 PM',  ];

  void _submitForm() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      final FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('available_veterinarians').add({
        'name': name,
        'specialization': specialization,
        'phone': phone,
        'email': email,
        'geolocation' : geolocation,
        'availableDays': availableDays,
        'availableHours': availableHours,
      });
      Navigator.pop(context);
    }
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      geolocation = GeoPoint(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Veterinarian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
                onSaved: (value) => name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter specialization',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter specialization';
                  }
                  return null;
                },
                onSaved: (value) => specialization = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter phone number',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                onSaved: (value) => phone = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter email address',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email address';
                  }
                  return null;
                },
                onSaved: (value) => email = value,
              ),
              ElevatedButton(
                onPressed: _getCurrentLocation,
                child: const Text('Get Current Location'),
              ),
              geolocation != null ? Text('Latitude: ${geolocation!.latitude.toStringAsFixed(2)} Longitude: ${geolocation!.longitude.toStringAsFixed(2)}') : Container(),
              Row(
                children: [
                  const Text('Available Days: '),
                  for (var day in daysOfWeek)
                    Row(
                      children: [
                        Checkbox(
                          value:
availableDays!.contains(day),
onChanged: (bool? value) {
setState(() {
if (value != null && value) {
availableDays!.add(day);
} else {
availableDays!.remove(day);
}
});
},
),
Text(day),
],
),
],
),
Row(
children: [
const Text('Available Hours: '),
for (var hour in hoursOfDay)
Row(
children: [
Checkbox(
value:
availableHours!.contains(hour),
onChanged: (bool? value) {
setState(() {
if (value != null && value) {
availableHours!.add(hour);
} else {
availableHours!.remove(hour);
}
});
},
),
Text(hour),
],
),
],
),
Padding(
padding: const EdgeInsets.symmetric(vertical: 16.0),
child: ElevatedButton(
onPressed: _submitForm,
child: const Text('Add Veterinarian'),
),
),
],
),
),
),
);
}
}