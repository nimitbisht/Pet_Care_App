import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/screens/pages/doctors/vet_form.dart';
import 'package:pet_care/screens/pages/doctors/vet_detail.dart';
import 'package:pet_care/screens/pages/doctors/edit_vet_form.dart';
import 'package:pet_care/screens/pages/doctors/verify_doctor.dart';

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
            return const Text('Loading...');
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
              'is_verified': data['is_verified'],
            };
          }).toList();

          return ListView.builder(
            itemCount: vets.length,
            itemBuilder: (context, index) {
              return ListTile(
              title: Text(vets[index]['name']),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(vets[index]['specialization'] ?? 'N/A'),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 16),
                        const SizedBox(width: 5),
                        Text(vets[index]['phone'] ?? 'N/A'),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.email, size: 16),
                        const SizedBox(width: 5),
                        Text(vets[index]['email'] ?? 'N/A'),
                      ],
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditVetForm(vet: vets[index]),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.verified),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyDoctorButton( vet: vets[index]['id'], 
  isVerified: vets[index]['is_verified'] ?? false,),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text('Are you sure you want to delete this veterinarian?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    FirebaseFirestore.instance.collection('available_veterinarians').doc(vets[index]['id']).delete();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
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
