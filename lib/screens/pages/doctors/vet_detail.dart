import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/screens/pages/doctors/vet_form.dart';

class VetDetails extends StatelessWidget {
  final Map<String, dynamic> vet;

  const VetDetails({super.key, required this.vet});

  @override
  Widget build(BuildContext context) {
    final availableDays = vet['availableDays']?.cast<String>() ?? [];
    final availableHours = vet['availableHours']?.cast<String>() ?? [];
    final weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final hoursOfDay = [    '9:00 AM - 12:00 PM',    '1:00 PM - 4:00 PM',    '5:00 PM - 8:00 PM',    '9:00 PM - 11:00 PM',  ];
    availableDays.sort((a, b) => weekdays.indexOf(a).compareTo(weekdays.indexOf(b)));
    availableHours.sort((a, b) => hoursOfDay.indexOf(a).compareTo(hoursOfDay.indexOf(b)));
    return Scaffold(
      appBar: AppBar(
        title: Text(vet['name']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Specialization: ${vet['specialization'] ?? 'N/A'}'),
          Text('Phone: ${vet['phone'] ?? 'N/A'}'),
          Text('Email: ${vet['email'] ?? 'N/A'}'),
          Text('Location: ${vet['location'] ?? 'N/A'}'),
          Text('Available Days: ${availableDays.isEmpty ? 'N/A' : availableDays.join(', ')}'),
          Text('Available Hours: ${availableHours.isEmpty ? 'N/A' : availableHours.join(', ')}'),
        ],
      ),
    );
  }
}

class VetList extends StatelessWidget {
  const VetList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veterinarians'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('available_veterinarians').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final vets = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'id': doc.id,
              'name': data['name'],
              'specialization': data['specialization'],
              'phone': data['phone'],
              'email': data['email'],
              'location': data['location'],
              'availableDays': data['availableDays']?.cast<String>(),
              'availableHours': data['availableHours']?.cast<String>(),
            };
          }).toList();

          return ListView.builder(
            itemCount: vets.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(vets[index]['name']),
                subtitle: Text(vets[index]['specialization'] ?? 'N/A'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VetDetails(vet: vets[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddVetForm(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
