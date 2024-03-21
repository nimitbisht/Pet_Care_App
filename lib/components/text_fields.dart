import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final icon;

  const MyTextField({super.key, required this.controller, required this.obscureText, required this.hintText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue, fontSize: 18, fontWeight: FontWeight.w500 // Change this to your desired text color
            ),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(174, 244, 201, 228)),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(174, 244, 201, 228)),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          prefixIcon: icon,
          fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.grey.shade300,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade400 : Colors.black45,
          ),
        ),
      ),
    );
  }
}
