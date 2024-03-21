import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'booking_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingAppointment1 extends StatefulWidget {
  final String doctorId;

  const BookingAppointment1({super.key, required this.doctorId});

  @override
  State<BookingAppointment1> createState() => _BookingAppointment1State();
}

class _BookingAppointment1State extends State<BookingAppointment1> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  late String doctorId; // Store the doctorId here

  @override
  void initState() {
    super.initState();
    doctorId = widget.doctorId; // Assign the value from the widget prop to the state variable
    mockBookingService = BookingService(
      serviceName: 'Mock Service',
      serviceDuration: 45,
      bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
      bookingStart: DateTime(now.year, now.month, now.day, 8, 0),
    );
  }

  Stream<dynamic>? getBookingStreamMock({
    required DateTime end,
    required DateTime start,
  }) {
    return FirebaseFirestore.instance.collection('bookings').where('doctorId', isEqualTo: doctorId).snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<dynamic> uploadBookingMock({
    required BookingService newBooking,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
      start: newBooking.bookingStart,
      end: newBooking.bookingEnd,
    ));
    print('${newBooking.toJson()} has been uploaded');

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookingForm(
          doctorId: doctorId, // Pass the doctorId from the state variable
          date: newBooking.bookingStart,
          startTime: TimeOfDay.fromDateTime(newBooking.bookingStart),
          endTime: TimeOfDay.fromDateTime(newBooking.bookingEnd),
        ),
      ),
    );
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({
    required dynamic streamResult,
  }) {
    converted.clear();
    streamResult.forEach((booking) {
      if (booking.containsKey('startTime')) {
        String timeString = booking['startTime'];
        int startTime = int.parse(timeString.split(':')[0]);

        if (timeString.toLowerCase().contains('pm') && startTime != 12) {
          startTime += 12;
        }
        String stringTime = booking['endTime'];
        int endTime = int.parse(stringTime.split(':')[0]);

        if (stringTime.toLowerCase().contains('pm') && endTime != 12) {
          endTime += 12;
        }
        DateTimeRange range = DateTimeRange(
          start: DateTime(
            DateTime.parse(booking['date']).year,
            DateTime.parse(booking['date']).month,
            DateTime.parse(booking['date']).day,
            startTime,
            0,
          ),
          end: DateTime(
            DateTime.parse(booking['date']).year,
            DateTime.parse(booking['date']).month,
            DateTime.parse(booking['date']).day,
            endTime,
            0,
          )
          // .add(const Duration(minutes: 30))
          ,
        );
        converted.add(range);
      }
    });

    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    List<DateTimeRange> pauseSlots = [];

    DateTime currentDate = DateTime.now();

    // Generate pause slots for 7 consecutive days
    for (int i = 0; i < 365; i++) {
      DateTime startTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
        13,
        0,
      );
      DateTime endTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
        14,
        0,
      );

      pauseSlots.add(DateTimeRange(start: startTime, end: endTime));

      // Move to the next day
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return pauseSlots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Booking Appointment'),
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
      body: Center(
        child: BookingCalendar(
          bookingService: mockBookingService,
          convertStreamResultToDateTimeRanges: convertStreamResultMock,
          getBookingStream: getBookingStreamMock,
          uploadBooking: uploadBookingMock,
          pauseSlots: generatePauseSlots(),
          pauseSlotText: 'LUNCH',
          hideBreakTime: false,
          loadingWidget: const Text('Fetching data...'),
          uploadingWidget: const CircularProgressIndicator(),
          locale: 'en_US', // Set the locale to English
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableSlotTextStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black, fontWeight: FontWeight.w500,fontSize: 16),
          availableSlotColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800: Colors.green.shade200,
          selectedSlotColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
          bookingButtonColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
          selectedSlotTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          wholeDayIsBookedWidget: const Text('Sorry, for this day everything is booked'),
        ),
      ),
    );
  }
}
