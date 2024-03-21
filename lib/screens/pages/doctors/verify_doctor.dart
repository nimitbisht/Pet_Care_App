import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerifyDoctorButton extends StatefulWidget {
  final String vet;
  final bool isVerified;

  const VerifyDoctorButton({super.key, required this.vet, required this.isVerified});

  @override
  _VerifyDoctorButtonState createState() => _VerifyDoctorButtonState();
}

class _VerifyDoctorButtonState extends State<VerifyDoctorButton> {
  bool _isVerified = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _isVerified = widget.isVerified;
  }

  Future<void> _toggleVerification() async {
    setState(() {
      _isSaving = true;
    });

    try {
      final doctorRef = FirebaseFirestore.instance.collection('available_veterinarians').doc(widget.vet);
      await doctorRef.update({'is_verified': !_isVerified});
      setState(() {
        _isVerified = !_isVerified;
      });
    } catch (e) {
      // handle error
      print('Error verifying doctor: $e');
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isSaving ? null : _toggleVerification,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (_isVerified) {
              return Colors.green;
            } else {
              return Colors.red;
            }
          },
        ),
      ),
      child: _isSaving
          ? const CircularProgressIndicator()
          : _isVerified
              ? const Text('Unverify')
              : const Text('Verify'),
    );
  }
}
