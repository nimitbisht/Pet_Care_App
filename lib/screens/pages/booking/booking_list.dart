import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'booking_detail.dart';

class BookingList extends StatefulWidget {
  final String userId;

  const BookingList({super.key, required this.userId});

  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  String selectedFilter = 'All';
  final int _selectedIndex = 1; // initialize the selected index to 0

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdaf2f7),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: Colors.black),
      //   title: Text(
      //     'Bookings',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   // actions: <Widget>[
      //   //   IconButton(
      //   //     icon: Icon(Icons.add),
      //   //     color: Colors.black,
      //   //     onPressed: () {
      //   //       Navigator.push(
      //   //         context,
      //   //         MaterialPageRoute(builder: (context) => AddBookingForm()),
      //   //       );
      //   //     },
      //   //   ),
      //   // ],
      // ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('My Booking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterButtons(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('bookings').where('userId', isEqualTo: widget.userId).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final bookings = snapshot.data!.docs;
                final filteredBookings = _filterBookings(bookings);

                if (filteredBookings.isEmpty) {
                  return Container(
                    decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white70),
                    alignment: Alignment.center,
                    child: const Text(
                      'No bookings!!!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                    ),
                  );
                }

                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white70,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      final booking = filteredBookings[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            booking['petName'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            booking['date'],
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // IconButton(
                              //   icon: Icon(Icons.edit),
                              //   color: Colors.grey,
                              //   onPressed: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(builder: (context) => EditBookingForm(bookingId: booking.id)),
                              //     );
                              //   },
                              // ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: booking['status'] == 'Completed'
                                    ? () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Delete Booking?'),
                                              content: const Text('Are you sure you want to delete this booking?'),
                                              actions: [
                                                TextButton(
                                                  child: const Text('CANCEL'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('DELETE'),
                                                  onPressed: () {
                                                    FirebaseFirestore.instance.collection('bookings').doc(booking.id).delete();
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    : null,
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookingDetailScreen(bookingId: booking.id)),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white70,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFilterButton('All'),
            const SizedBox(width: 8),
            _buildFilterButton('Pending'),
            const SizedBox(width: 8),
            // _buildFilterButton('Cancelled'),
            // SizedBox(width: 8),
            _buildFilterButton('Completed'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String filter) {
    final isSelected = filter == selectedFilter;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedFilter = filter;
        });
      },
      style: ButtonStyle(
        backgroundColor: isSelected
            ? MaterialStateProperty.all<Color>(
                Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
              )
            : null,
        foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
      ),
      child: Text(
        filter,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  List<DocumentSnapshot> _filterBookings(List<DocumentSnapshot> bookings) {
    if (selectedFilter == 'All') {
      return bookings;
    } else {
      return bookings.where((booking) => booking['status'] == selectedFilter).toList();
    }
  }
}
