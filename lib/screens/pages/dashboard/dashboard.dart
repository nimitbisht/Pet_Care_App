import 'package:flutter/material.dart';
import 'package:pet_care/screens/pages/dashboard/editProfile/edit_profile_screen.dart';
import 'package:pet_care/screens/pages/records/medical.dart';
class PetCareDashboard extends StatelessWidget {
  const PetCareDashboard({super.key});


  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
    );
  }

  void _navigateToMedicalRecords(BuildContext context) {
    // Add code to navigate to Medical Records screen
   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Medical()),
    );
  }

  void _navigateToSettings(BuildContext context) {
    // Add code to navigate to Settings screen
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: const Center(
          child: Text('This is the Setting screen'),
        ),
        ),
      ),
    );
  }

  void _navigateToFeedback(BuildContext context) {
    // Add code to navigate to Feedback screen
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Feedback Records'),
        ),
        body: const Center(
          child: Text('This is the feedback screen'),
        ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Container(
        color: const Color(0xffdaf2f7),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Profile Dashboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () => _navigateToEditProfile(context),
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToMedicalRecords(context),
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.history,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Medical Records',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToSettings(context),
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToFeedback(context),
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.feedback,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Feedback',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black),
),
),
),
],
),
),
],
),
),
),
);
}

}
