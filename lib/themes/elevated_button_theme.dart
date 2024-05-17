import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  static final ElevatedButtonThemeData defaultTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        EdgeInsets.fromLTRB(12, 16, 12, 16),
      ),
      minimumSize: MaterialStateProperty.all(Size.fromHeight(54)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return Color(0xFFEBEBEB);
        }
        return Color(0xFF2A2A2A);
      }),
    ),
  );
}