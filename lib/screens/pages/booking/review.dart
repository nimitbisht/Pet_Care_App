import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/screens/pages/booking/reviewScreen.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final revData = FirebaseFirestore.instance.collection('reviews').doc('uid').get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Reviews"),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReviewScreen(),
                  ),
                );
              })
        ],
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: [
          const SizedBox(height: 10),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10), //border corner radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), //color of shadow
                  spreadRadius: 3, //spread radius
                  blurRadius: 2, // blur radius
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text(
                    "User name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: SmoothStarRating(
                    rating: 4.4, // rating to be added through database
                    size: 20,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
                    borderColor: Colors.amber,
                    filledIconData: Icons.star_rate,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                  ),
                ),
                const ListTile(
                  subtitle: Text("Lorem ipsum dolor sit amet. Ea corrupti consequatur et dolores quisquam vel omnis soluta sit dicta corrupti sed pariatur quasi qui repellat rerum est mollitia iure. Non recusandae atque et adipisci ullam qui repudiandae obcaecati qui harum dolore aut modi eveniet ut ipsa libero. Ut atque officia ea aspernatur vitae qui maiores voluptates?", textAlign: TextAlign.justify),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10), //border corner radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), //color of shadow
                  spreadRadius: 3, //spread radius
                  blurRadius: 2, // blur radius
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text(
                    "User name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: SmoothStarRating(
                    rating: 4.4, // rating to be added through database
                    size: 20,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
                    borderColor: Colors.amber,
                    filledIconData: Icons.star_rate,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                  ),
                ),
                const ListTile(
                  subtitle: Text("Lorem ipsum dolor sit amet. Ea corrupti consequatur et dolores quisquam vel omnis soluta sit dicta corrupti sed pariatur quasi qui repellat rerum est mollitia iure. Non recusandae atque et adipisci ullam qui repudiandae obcaecati qui harum dolore aut modi eveniet ut ipsa libero. Ut atque officia ea aspernatur vitae qui maiores voluptates?", textAlign: TextAlign.justify),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10), //border corner radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), //color of shadow
                  spreadRadius: 3, //spread radius
                  blurRadius: 2, // blur radius
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text(
                    "User name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: SmoothStarRating(
                    rating: 4.4, // rating to be added through database
                    size: 20,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
                    borderColor: Colors.amber,
                    filledIconData: Icons.star_rate,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                  ),
                ),
                const ListTile(
                  subtitle: Text("Lorem ipsum dolor sit amet. Ea corrupti consequatur et dolores quisquam vel omnis soluta sit dicta corrupti sed pariatur quasi qui repellat rerum est mollitia iure. Non recusandae atque et adipisci ullam qui repudiandae obcaecati qui harum dolore aut modi eveniet ut ipsa libero. Ut atque officia ea aspernatur vitae qui maiores voluptates?", textAlign: TextAlign.justify),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10), //border corner radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), //color of shadow
                  spreadRadius: 3, //spread radius
                  blurRadius: 2, // blur radius
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text(
                    "User name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: SmoothStarRating(
                    rating: 4.4, // rating to be added through database
                    size: 20,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
                    borderColor: Colors.amber,
                    filledIconData: Icons.star_rate,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                  ),
                ),
                const ListTile(
                  subtitle: Text("Lorem ipsum dolor sit amet. Ea corrupti consequatur et dolores quisquam vel omnis soluta sit dicta corrupti sed pariatur quasi qui repellat rerum est mollitia iure. Non recusandae atque et adipisci ullam qui repudiandae obcaecati qui harum dolore aut modi eveniet ut ipsa libero. Ut atque officia ea aspernatur vitae qui maiores voluptates?", textAlign: TextAlign.justify),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10), //border corner radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), //color of shadow
                  spreadRadius: 3, //spread radius
                  blurRadius: 2, // blur radius
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text(
                    "User name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: SmoothStarRating(
                    rating: 4.4, // rating to be added through database
                    size: 20,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange : Colors.blue,
                    borderColor: Colors.amber,
                    filledIconData: Icons.star_rate,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                  ),
                ),
                const ListTile(
                  subtitle: Text("Lorem ipsum dolor sit amet. Ea corrupti consequatur et dolores quisquam vel omnis soluta sit dicta corrupti sed pariatur quasi qui repellat rerum est mollitia iure. Non recusandae atque et adipisci ullam qui repudiandae obcaecati qui harum dolore aut modi eveniet ut ipsa libero. Ut atque officia ea aspernatur vitae qui maiores voluptates?", textAlign: TextAlign.justify),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
