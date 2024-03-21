import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_care/ZOne/homescreen.dart';
import 'package:uuid/uuid.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String address;
  final String city;
  final String state;
  final String postal;
  final String phone;
  final int orderTotal;
  final List<dynamic> products;

  const PaymentScreen({
    super.key,
    required this.address,
    required this.city,
    required this.state,
    required this.postal,
    required this.phone,
    required this.orderTotal,
    required this.products,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<String> paymentMethodImgs = [
    'assets/ecommerce/cod.jpg',
    'assets/ecommerce/paytm.jpg',
  ];

  String selectedPaymentMethod = "Cash on Delivery";

  var paymentIndex = 0;

  changePaymentIndex(value) {
    setState(() {
      paymentIndex = value;
    });
  }

  // function to clear cart
  void clearCart() {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    // Delete all items in the cart for the current user
    FirebaseFirestore.instance.collection('Cart').where("Added_by", isEqualTo: userId).get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  var Orderproducts = [];

  // get product detail from database
  getProductDetails() {
    Orderproducts.clear(); // Clear the list to avoid duplicates

    for (var product in widget.products) {
      Orderproducts.add({
        'Name': product['Name'],
        'Price': product['Price'],
        'Quantity': product['Quantity'],
        'Image': product['Image'],
      });
    }

    print(Orderproducts);
  }

  // Show the order summary at the chekout screen
  List<Widget> createOrderSummary() {
    final List<Widget> orderSummaryWidgets = [];

    for (int i = 0; i < widget.products.length; i++) {
      orderSummaryWidgets.add(ListTile(
        contentPadding: const EdgeInsets.all(0),
        isThreeLine: true,
        leading: Image.network(widget.products[i]['Image']),
        title: Row(
          children: [
            Text(
              widget.products[i]['Name'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quantity: ${widget.products[i]['Quantity']}"),
            Text('Total Price: Rs ${widget.products[i]['Total_Price'].toStringAsFixed(2)}'),
          ],
        ),
      ));

      if (i < widget.products.length - 1) {
        // Add a divider after each product except the last one
        orderSummaryWidgets.add(const Divider(height: 5));
      }
    }

    return orderSummaryWidgets;
  }

  // ignore: non_constant_identifier_names
  Future<void> placeOrder({orderPaymentMethod, OrderTotal}) async {
    await getProductDetails();
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();
    final PAYId = const Uuid().v4();
    final user = FirebaseAuth.instance.currentUser!;

    if (orderPaymentMethod == 'Card/UPI') {
      Razorpay razorpay = Razorpay();
      var options = {
        'key': 'rzp_test_eGOesw1IMisiDt',
        'timeout': '300',
        'currency': 'INR',
        'amount': OrderTotal * 100,
        // 'order_id': orderId,
        'name': 'Petcare and Aid',
        'prefill': {'contact': widget.phone, 'email': user.email},
        'external': {
          'wallets': ['paytm']
        },
      };
      try {
        razorpay.open(options);
      } catch (e) {
        debugPrint(e.toString());
      }

      void handlePaymentErrorResponse(PaymentFailureResponse response) {
        debugPrint('Payment fail');
      }

      void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
        debugPrint("Payment ID: ${response.paymentId}");

        final order = FirebaseFirestore.instance.collection('Orders').doc().set({
          'Order_by': user.uid,
          'Order_id': orderId,
          'Payment_id': response.paymentId,
          'Name': user.displayName,
          'Email': user.email,
          'Address': widget.address,
          'City': widget.city,
          'State': widget.state,
          'Postal Code': widget.postal,
          'Phone': widget.phone,
          'Order_time': FieldValue.serverTimestamp(),
          'Shipping Method': "Home Delivery", //change later
          'Payment Method': orderPaymentMethod,
          'Total amount': OrderTotal,
          'Orders': FieldValue.arrayUnion(Orderproducts),
        });

        clearCart();
        Fluttertoast.showToast(
          msg: 'Order placed Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      }

      void handleExternalWalletSelected(ExternalWalletResponse response) async {
        debugPrint('External Wallet');
        debugPrint("Payment ID: ${response.walletName}");

        Fluttertoast.showToast(
          msg: 'Order placed Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        //
      }

      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    }

    if (orderPaymentMethod == "Cash on Delivery") {
      final order = await FirebaseFirestore.instance.collection('Orders').doc().set({
        'Order_by': user.uid,
        'Order_id': orderId,
        'Payment_id': PAYId,
        'Name': user.displayName,
        'Email': user.email,
        'Address': widget.address,
        'City': widget.city,
        'State': widget.state,
        'Postal Code': widget.postal,
        'Phone': widget.phone,
        'Order_time': FieldValue.serverTimestamp(),
        'Shipping Method': "Home Delivery", //change later
        'Payment Method': orderPaymentMethod,
        'Total amount': OrderTotal,
        'Orders': FieldValue.arrayUnion(Orderproducts),
      });

      clearCart();
      Fluttertoast.showToast(
        msg: 'Order placed Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Choose Payment Method"),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.grey.shade400,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: "Cash on Delivery",
                      groupValue: selectedPaymentMethod,
                      focusColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    ),
                    const Text("Cash on Delivery"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Card/UPI",
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    ),
                    const Text("Card/UPI"),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Summary:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Create and display the order summary widgets
                ...createOrderSummary(),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          placeOrder(
            OrderTotal: widget.orderTotal,
            orderPaymentMethod: selectedPaymentMethod,
          );
        },
        child: Container(
          margin: const EdgeInsets.all(15),
          alignment: Alignment.center,
          width: 150, // Set the image width as per your design
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
          ),
          child: Text(
            "Place my Order".toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
