import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        const SizedBox(width: 5),
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.circular(10), //border corner radius
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), //color of shadow
                spreadRadius: 3, //spread radius
                blurRadius: 2, // blur radius
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "User name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text("1 day ago"),
              ),
              ListTile(
                subtitle: Text("Sit is a good doctor pets that have titanus"),
              )
            ],
          ),
        ),
        const SizedBox(width: 15),
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.circular(10), //border corner radius
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), //color of shadow
                spreadRadius: 3, //spread radius
                blurRadius: 2, // blur radius
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "User name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text("1 day ago"),
              ),
              ListTile(
                subtitle: Text("Sit is a good doctor pets that have titanus"),
              )
            ],
          ),
        ),
        const SizedBox(width: 15),
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.circular(10), //border corner radius
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), //color of shadow
                spreadRadius: 3, //spread radius
                blurRadius: 2, // blur radius
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "User name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text("1 day ago"),
              ),
              ListTile(
                subtitle: Text("Sit is a good doctor pets that have titanus"),
              )
            ],
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
