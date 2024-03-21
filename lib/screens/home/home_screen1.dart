import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/screens/pages/dashboard/dashboard.dart';
import 'navbar_items.dart';
import 'package:pet_care/screens/pages/index/home.dart';
import 'package:pet_care/screens/pages/schedule/schedule.dart';
import 'package:pet_care/screens/pages/doctors/vet_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final user = FirebaseAuth.instance.currentUser!;
  
  final List<Widget> _screens = [
   const VetList(),
   const Schedule(),
   const Home(),
  //  const PetShoppingList(),
   const PetCareDashboard(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = bottomNavBarItems;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Care'),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: _bottomNavBarItems,
      ),
    );
  }
}
