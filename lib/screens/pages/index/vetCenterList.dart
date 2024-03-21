import 'package:flutter/material.dart';
class VetCenter {
  final String name;
  final String address;
  final String phoneNumber;

  VetCenter({
    required this.name,
    required this.address,
    required this.phoneNumber,
  });
}

class VetCenterList extends StatelessWidget {
  final List<VetCenter> vetCenters = [
    VetCenter(
      name: 'Animal Hospital',
      address: '123 Main St, Anytown USA',
      phoneNumber: '555-555-1234',
    ),
    VetCenter(
      name: 'Paws & Claws Vet Clinic',
      address: '456 Maple Ave, Anytown USA',
      phoneNumber: '555-555-5678',
    ),
    VetCenter(
      name: 'Pet Wellness Center',
      address: '789 Oak St, Anytown USA',
      phoneNumber: '555-555-9012',
    ),
  ];

  VetCenterList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: vetCenters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300] ?? Colors.white,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    vetCenters[index].name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    vetCenters[index].address,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    vetCenters[index].phoneNumber,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
