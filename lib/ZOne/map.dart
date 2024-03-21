import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/pages/booking/booking_appointment.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

Future<void> _requestLocationPermission() async {
  final status = await Permission.location.request();
  if (status.isGranted) {
    // Permission granted, do something here
    print('Location permission granted!');
    // const message = '';
    // Fluttertoast.showToast(msg: message,fontSize: 14);
  } else {
    // Permission denied, show error message
    const message = 'Location permission not granted';
    Fluttertoast.showToast(msg: message, fontSize: 14);
    print('Location permission denied!');
  }
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController controller;

  late GoogleMapController _controller;
  late StreamSubscription<Position> _positionStream;
  LatLng _initialCameraPosition = const LatLng(28.7041, 77.1025);

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  DateTime? lastTap;

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;

    List<QueryDocumentSnapshot> filteredDoctors;

    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      // onTap: _onMarkerTapped,
      position: LatLng(specify['map_location'].latitude, specify['map_location'].longitude),
      infoWindow: InfoWindow(
          title: 'Veterinary Clinic',
          snippet: specify['name'],
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Schedule()),
            // );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingAppointment(doctorId: specifyId)),
            );

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Scaffold(
            //       body: BookingAppointment(doctorId: detail.id),
            //
            //
            //     ),
            //   ),
            // );
          }),

      icon: await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/images/veterinarian.png', // Replace with your custom icon path
      ),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  Future<void> getMarkerData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('available_veterinarians').get();
    if (querySnapshot.docs.isNotEmpty) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        initMarker(querySnapshot.docs[i].data(), querySnapshot.docs[i].id);
      }
    }
  }

  @override
  void initState() {
    _requestLocationPermission();

    _positionStream = Geolocator.getPositionStream(
            // desiredAccuracy: LocationAccuracy.high,
            // distanceFilter: 10,
            )
        .listen((position) {
      setState(() {
        _initialCameraPosition = LatLng(position.latitude, position.longitude);
      });
      _controller.animateCamera(CameraUpdate.newLatLng(_initialCameraPosition));
    });

    super.initState();
    getMarkerData();
  }

  int _selectedIndex = 0; // initialize the selected index to 0

  @override
  Widget build(BuildContext context) {
    ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.green[700],
    );
    Set<Marker> getMarker() {
      return <Marker>{
        Marker(
          markerId: const MarkerId('Veterinary Clinic'),
          position: const LatLng(28.7041, 77.1025),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(title: 'Home'),
          onTap: () {
            // Handle marker info window tapped
            print('Marker info window tapped: Home');
          },
        )
      };
    }

    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],

        
        title: Text.rich(
          TextSpan(
            style: const TextStyle(),
            children: [
              const TextSpan(
                text: 'Nearby Pet Care',
                style: TextStyle(
                  fontSize: 27,
                  fontFamily: 'Quicksand',
                  // fontFamily: 'Spartan MB',
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 2,
                ),
              ),
              WidgetSpan(
                child: Image.asset(
                  'assets/images/map2.gif',
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
      body: GoogleMap(
        markers: markers.values.toSet(),
        mapType: MapType.terrain,
        initialCameraPosition: const CameraPosition(
          target: LatLng(28.7041, 77.1025),
          zoom: 14.0,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            this.controller = controller;
          });
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0.0, left: 31.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                markers.clear();
              });
              getMarkerData();
            },
            child: const Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
