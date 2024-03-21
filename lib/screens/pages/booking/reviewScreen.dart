import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Add Review"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Give  Review",
              ),
              const SizedBox(height: 15),
              SmoothStarRating(
                rating: rating,
                size: 40,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                borderColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                filledIconData: Icons.star_rate,
                halfFilledIconData: Icons.star_half,
                defaultIconData: Icons.star_border,
                starCount: 5,
                allowHalfRating: true,
                onRatingChanged: (value) {
                  setState(
                    () {
                      rating = value;
                      print("The rating is $rating");
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
              ),
              // controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              decoration: InputDecoration(
                
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(173, 249, 231, 242),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                
                hintText: "type your review here",
                hintStyle: const TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print("preseed");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 18.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: const Text('Submit Review'),
          ),
        ],
      ),
    );
  }
}
