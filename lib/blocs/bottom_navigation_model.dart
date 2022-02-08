import 'package:flutter/material.dart';

class BottomNavigationModel {
  final IconData icon;
  final String label;
  final String path;

  BottomNavigationModel({
    required this.icon,
    required this.label,
    required this.path,
  });
}

List<BottomNavigationModel> get bottomNavigationItems => [
  BottomNavigationModel(
    icon: Icons.home,
    label: "Home",
    path: "/home",
  ),
  BottomNavigationModel(
    icon: Icons.analytics_outlined,
    label: "Bookings",
    path: "/mybookings",
  ),
  BottomNavigationModel(
    icon: Icons.account_circle_rounded,
    label: "Profile",
    path: "/profile",
  ),

];