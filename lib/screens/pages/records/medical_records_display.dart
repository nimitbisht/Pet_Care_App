import 'package:flutter/material.dart';

class MedicalRecordsDisplay extends StatelessWidget {
  final List<Map<String, dynamic>> records;

  const MedicalRecordsDisplay({Key? key, required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Medical Records'),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xffdaf2f7),
        child: Column(
        children: [
          Expanded(
            child: ListView.builder(
  itemCount: records.length,
  itemBuilder: (BuildContext context, int index) {
    final record = records[index];
    final date = record['date'] as String;
    final doctor = record['doctor'] as String;
    final diagnosis = record['diagnosis'] as String;
    final medications = record['medications'] as List<String>;
    final itemIndex = index + 1; // calculate the item index
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               
                Text(
                  'Record Number: $itemIndex', // display the item index
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 19, 178, 136),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                        const Icon(
                          Icons.person,
                          size: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          doctor,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 24,
                  ),
                ],
              ),

              ],
            ),
            
            const SizedBox(height: 16),
            Text(
              'Date:',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Diagnosis:',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              diagnosis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Medications:',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: medications
                  .map((medication) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, size: 16, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(medication, style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  },
),

          ),
        ],
      ),
     ),
    );
  }
}
