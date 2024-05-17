import 'package:flutter/material.dart';

class AppBottomNavigationBarTheme {
  static final BottomNavigationBarThemeData defaultTheme =
      BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w400,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w400,
    ),
    selectedItemColor: Color(0xFF2A2A2A),
  );
}