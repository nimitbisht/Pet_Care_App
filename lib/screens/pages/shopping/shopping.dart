import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:pet_care/screens/pages/shopping/add_cart.dart';
import 'package:pet_care/screens/pages/shopping/models/product.dart';
import 'package:pet_care/screens/pages/shopping/product_card.dart';
import 'package:pet_care/screens/pages/shopping/product_detail.dart';

class Shopping extends StatefulWidget {
  const Shopping({
    super.key,
  });

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  String selectedCategory = "All";
  final List<String> categories = ['All', 'Food', 'Feeder', 'Toys', 'Grooming', 'Health'];

  @override
  Widget build(BuildContext context) {
    // final filteredProducts = getFilteredProducts();
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade100,
      appBar: AppBar(
        leading: const BackButton(),
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade500 : Colors.blue,
        title: const Text(
          "Pet Store",
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(15),
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              // Handle shopping cart action
              // open cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddtoCart(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FilterChip(
                      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
                      label: Text(
                        category,
                        style: TextStyle(fontSize: screenWidth / 25),
                      ),
                      selectedColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade600 : Colors.blue.shade400,
                      selected: selectedCategory == category,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = (selected ? category : null)!;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          StreamBuilder(
            stream: (selectedCategory == "All") ? FirebaseFirestore.instance.collection('Products').snapshots() : FirebaseFirestore.instance.collection('Products').where("Category", isEqualTo: selectedCategory).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Connection Error");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              List<Product> products = snapshot.data!.docs.map(
                (doc) {
                  final data = doc.data();
                  return Product(
                    name: data['Name'],
                    price: data['Price'],
                    category: data['Category'],
                    description: data['Description'],
                    imageurl: data['ImageUrl'],
                    quantityCount: data['Quantity'],
                    rating: data['Rating'],
                  );
                },
              ).toList();

              return Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Adjust the number of columns as needed
                      crossAxisSpacing: 7.0, // Add spaqcing between columns
                      mainAxisSpacing: 7.0, // Add spacing between rows
                      childAspectRatio: (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height) / 0.6,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                pd: product,
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          pd: product,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
