import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/screens/pages/shopping/add_cart.dart';
import 'package:pet_care/screens/pages/shopping/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product pd;
  const ProductCard({
    super.key,
    required this.pd,
  });

  Future<void> addProductToCart() async {
    final user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('Cart').add(
      {
        'Name': pd.name,
        'Image': pd.imageurl,
        'Quantity': 1,
        'Price': pd.price,
        'Total_Price': pd.price,
        'Added_by': user?.uid, // Store the user's UID
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.2;
    return Card(
      color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
      
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8.0),
              ),
              child: Image.network(
                pd.imageurl,
                height: 155,
                width: double.infinity,
                
              ),
            ),
          ),
          Container(
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pd.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Rs ${pd.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    pd.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () {
                      addProductToCart();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddtoCart(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade600 : Colors.blue,
                      ),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
