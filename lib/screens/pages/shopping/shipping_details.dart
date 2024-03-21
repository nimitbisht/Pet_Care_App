import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/components/textField.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:pet_care/screens/pages/shopping/payment_screen.dart';

class ShippingDetails extends StatelessWidget {
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalcodeController = TextEditingController();
  final phoneController = TextEditingController();

  final int total;
  final dynamic products;

  ShippingDetails({super.key, required this.total, this.products});

  bool containsOnlyNumbers(String value) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(value);
  }

  validate(BuildContext context) {
    if (addressController.text.isNotEmpty && cityController.text.isNotEmpty && stateController.text.isNotEmpty && postalcodeController.text.length == 6 && phoneController.text.length == 10 && containsOnlyNumbers(phoneController.text)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            address: addressController.text,
            city: cityController.text,
            state: stateController.text,
            postal: postalcodeController.text.trim(),
            phone: phoneController.text.trim(),
            orderTotal: total,
            products: products,
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Please fill all Details correctly',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 2, // change it to get decimal places
    symbol: '₹ ',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Shipping Info"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Your Shipping Address:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              MyText(
                controller: addressController,
                hintText: "Address ",
              ),
              const SizedBox(height: 10),
              MyText(
                controller: cityController,
                hintText: "City",
              ),
              const SizedBox(height: 10),
              MyText(
                controller: stateController,
                hintText: "Enter state",
              ),
              const SizedBox(height: 10),
              MyText(
                controller: postalcodeController,
                hintText: "Enter postal code",
              ),
              const SizedBox(height: 10),
              MyText(
                controller: phoneController,
                hintText: "Enter phone number",
              ),
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: 180, // Set the image width as per your design
            height: 45,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            //   color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
            // ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Amt to be Paid",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        indianRupeesFormat.format(total),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              validate(context);
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.center,
              width: 150, // Set the image width as per your design
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
