import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final controller;
  final String hintText;

  const MyText({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
        ),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          // prefixIcon: icon,
          hintText: hintText,
        ),
      ),
    );
  }
}
