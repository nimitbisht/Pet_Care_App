import 'package:flutter/material.dart';
import 'medical_records_display.dart';

class Medical extends StatelessWidget {
  const Medical({super.key});

  @override
  Widget build(BuildContext context) {
    final records = [
      {
        'date': '2022-04-14',
        'doctor': 'Dr. Ram',
        'diagnosis': 'Fever',
        'medications': ['Antibiotics', 'Antiparasitics'],
      },
      {
        'date': '2022-04-12',
        'doctor': 'Dr. Shyam',
        'diagnosis': 'Common cold',
        'medications': ['Antifungals', 'Steroids'],
      },
      {
        'date': '2022-04-12',
        'doctor': 'Dr. Shyam',
        'diagnosis': 'Common cold',
        'medications': ['Pain Relievers', 'Doxepin'],
      },
      {
        'date': '2022-04-12',
        'doctor': 'Dr. Shyam',
        'diagnosis': 'Common cold',
        'medications': ['Ketoconazole ', 'Doxycycline '],
      },
    ];

    return Scaffold(
      body: MedicalRecordsDisplay(records: records),
    );
  }
}
