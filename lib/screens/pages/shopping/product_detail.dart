import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/screens/pages/shopping/add_cart.dart';
import 'package:pet_care/screens/pages/shopping/models/product.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ProductDetail extends StatefulWidget {
  final Product pd;

  const ProductDetail({
    super.key,
    required this.pd,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1;
  int totalPrice = 0;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    calculatePrice(); // Calculate the initial total price when the widget is initialized
  }

  increaseQuantity(totalQuantity) {
    setState(() {
      if (quantity < totalQuantity) {
        quantity++;
        calculatePrice();
      }
    });
  }

  decreaseQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity--;
        calculatePrice();
      }
    });
  }

  void calculatePrice() {
    var calculatedPrice = (quantity * widget.pd.price);
    setState(() {
      totalPrice = calculatedPrice;
    });
  }

  Future<void> addProductToCart({productName, image, qty, price, tprice}) async {
    final user = FirebaseAuth.instance.currentUser;
    final cart = await FirebaseFirestore.instance.collection('Cart').where('Name', isEqualTo: productName).where('Added_by', isEqualTo: user?.uid).get();

    if (cart.docs.isNotEmpty) {
      final cartdocs = cart.docs.first;
      final curQty = cartdocs['Quantity'] as int;
      final curTotalPrice = cartdocs['Total_Price'] as int;

      cartdocs.reference.update({'Quantity': curQty + qty, 'Total_Price': curTotalPrice + tprice});
    } else {
      await FirebaseFirestore.instance.collection('Cart').add(
        {
          'Name': productName,
          'Image': image,
          'Quantity': qty,
          'Price': price,
          'Total_Price': tprice,
          'Added_by': user?.uid, // Store the user's UID
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // add to cart
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      increaseQuantity(widget.pd.quantityCount);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    "$quantity",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(width: 15),
                  IconButton(
                    onPressed: () {
                      decreaseQuantity();
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                addProductToCart(
                  productName: widget.pd.name,
                  image: widget.pd.imageurl,
                  qty: quantity,
                  price: widget.pd.price,
                  tprice: totalPrice,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddtoCart(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: 150, // Set the image width as per your design
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(),
        title: Text(widget.pd.name),
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
          // list view of food details
          Expanded(
            child: ListView(
              children: [
                //image
                Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  height: 300, // Set the image height as per your design
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(widget.pd.imageurl),
                      fit: BoxFit.cover,
                    ),
                    // child: CachedNetworkImage(imageUrl: widget.pd.imageurl,
                    // imageBuilder: (context, imageProvider) {

                    // }),)
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.grey.shade300,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: const EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pd.name,
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SmoothStarRating(
                          rating: widget.pd.rating as double,
                          size: 18,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                          filledIconData: Icons.star_rate,
                          halfFilledIconData: Icons.star_half,
                          defaultIconData: Icons.star_border,
                          allowHalfRating: true,
                          starCount: 5,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Rs ${widget.pd.price}',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.pd.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Rs $totalPrice',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
