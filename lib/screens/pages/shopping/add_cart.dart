import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/screens/pages/shopping/shipping_details.dart';
import 'package:pet_care/screens/pages/shopping/shopping.dart';

// ignore: must_be_immutable
class AddtoCart extends StatelessWidget {
  AddtoCart({
    super.key,
  });

  late dynamic productSnapshot;
  // function to calculate cart total
  int cartTotal(List<DocumentSnapshot> cartData) {
    int t = 0;
    for (var item in cartData) {
      int itemPrice = item['Total_Price'];
      t += itemPrice;
    }
    return t;
  }

  deleteProductfromCart(DocumentReference docId) {
    docId.delete();
  }

  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    int total = 0;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('My Cart'),
      ),
      body: Container(
        padding: const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Cart').where("Added_by", isEqualTo: userId).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Empty Cart".toUpperCase(),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text("You have no items in your cart"),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Shopping(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 200, // Set the image width as per your design
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                        ),
                        child: const Text(
                          "Continue Shopping",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              var data = snapshot.data!.docs;
              total = cartTotal(data);
              productSnapshot = data;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          surfaceTintColor: Colors.white24,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          shadowColor: Colors.grey,
                          child: ListTile(
                            leading: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image.network("${data[index]['Image']}"),
                            ),
                            title: Text("${data[index]['Name']} "),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Price: Rs ${data[index]['Total_Price'].toStringAsFixed(2)}"),
                                Text("Quantity: ${data[index]['Quantity']}"),
                              ],
                            ),

                            // product delete button
                            trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 3,
                                      backgroundColor: Colors.white,
                                      child: Container(
                                        width: 250,
                                        height: 180,
                                        padding: const EdgeInsets.all(10),
                                        // decoration: BoxDecoration(
                                        //   shape: BoxShape.rectangle,
                                        //   borderRadius: BorderRadius.circular(10),
                                        // ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Confirm Deletion",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            const Text(
                                              "Are you sure you want to delete this item?",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                            ),
                                            const SizedBox(height: 22),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                        color: Colors.blueGrey.shade300,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteProductfromCart(data[index].reference);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(
                                                      "Yes, Remove it",
                                                      style: TextStyle(
                                                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              splashRadius: 25.0,
                              icon: const Icon(Icons.delete),
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8),
                  //   height: 250,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //     color: Colors.white10,
                  //   ),
                  // ),
                  Container(
                    height: 60,
                    width: 450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.amber.shade400 : Colors.blue,
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Rs ${total.toStringAsFixed(2)}",
                            // convert int to string
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShippingDetails(
                            total: total,
                            products: productSnapshot,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 450,
                      // margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.brown.shade400 : Color.fromARGB(255, 35, 77, 111),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Proceed to Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
