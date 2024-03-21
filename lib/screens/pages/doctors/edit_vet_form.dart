import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditVetForm extends StatefulWidget {
  final Map<String, dynamic> vet;

  const EditVetForm({super.key, required this.vet});

  @override
  _EditVetFormState createState() => _EditVetFormState();
}

class _EditVetFormState extends State<EditVetForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _specializationController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _locationController;
  late List<String> _availableDays;
  late List<String> _availableHours;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.vet['name']);
    _specializationController = TextEditingController(text: widget.vet['specialization'] ?? '');
    _phoneController = TextEditingController(text: widget.vet['phone'] ?? '');
    _emailController = TextEditingController(text: widget.vet['email'] ?? '');
    _locationController = TextEditingController(text: widget.vet['location'] ?? '');
    _availableDays = widget.vet['availableDays']?.cast<String>() ?? [];
    _availableHours = widget.vet['availableHours']?.cast<String>() ?? [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specializationController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final vetRef = FirebaseFirestore.instance.collection('available_veterinarians').doc(widget.vet['id']);
      await vetRef.update({
        'name': _nameController.text,
        'specialization': _specializationController.text.isNotEmpty ? _specializationController.text : null,
        'phone': _phoneController.text.isNotEmpty ? _phoneController.text : null,
        'email': _emailController.text.isNotEmpty ? _emailController.text : null,
        'location': _locationController.text.isNotEmpty ? _locationController.text : null,
        'availableDays': _availableDays.isNotEmpty ? _availableDays : null,
        'availableHours': _availableHours.isNotEmpty ? _availableHours : null,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Veterinarian'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _specializationController,
                  decoration: const InputDecoration(
                    labelText: 'Specialization',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Available Days', style: TextStyle(fontSize: 16)),
                Wrap(
                  children: [
                    for (final day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'])
                      CheckboxListTile(
                        title: Text(day),
                        value: _availableDays.contains(day),
                        onChanged: (bool? checked) {
                          setState(() {
                            if (checked != null) {
                              if (checked) {
                                _availableDays.add(day);
                              } else {
                                _availableDays.remove(day);
                              }
                            }
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Available Hours', style: TextStyle(fontSize: 16)),
                Wrap(
                  children: [
                    for (final hour in ['9:00 AM - 12:00 PM',    '1:00 PM - 4:00 PM',    '5:00 PM - 8:00 PM',    '9:00 PM - 11:00 PM',])
                      CheckboxListTile(
                        title: Text(hour),
                        value: _availableHours.contains(hour),
                        onChanged: (bool? checked) {
                          setState(() {
                            if (checked != null) {
                              if (checked) {
                                _availableHours.add(hour);
                              } else {
                                _availableHours.remove(hour);
                              }
                            }
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Update Veterinarian'),
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

