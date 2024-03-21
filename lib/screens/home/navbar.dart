import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final List<Map<String, dynamic>> routes;
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.routes, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: routes.map((route) => BottomNavigationBarItem(
        icon: Icon(route['icon']),
        label: route['label'],
      )).toList(),
    );
  }
}
