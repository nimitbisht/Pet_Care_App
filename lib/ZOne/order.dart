import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/ZOne/order_detail.dart';

class Orders extends StatelessWidget {
  Orders({super.key});

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
        title: const Text("My Orders",style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders').orderBy('Order_time', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No orders yet!!!".toUpperCase(),
                style: const TextStyle(fontSize: 20),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.grey.shade300,
                  ),
                  child: ListTile(
                    leading: Text(
                      '#${index + 1} )',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      ),
                    ),
                    title: Text(
                      data[index]['Order_id'].toString(),
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      ),
                    ),
                    subtitle: Text(
                      indianRupeesFormat.format(
                        data[index]['Total amount'],
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetail(orderdata: data[index]),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      ),
                      splashRadius: 20,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
