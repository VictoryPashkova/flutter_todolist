import 'package:flutter/material.dart';

class AppInputDecorationTheme {
  static final InputDecorationTheme defaultTheme = InputDecorationTheme(
    constraints: BoxConstraints(minHeight: 68),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 12),
    labelStyle: TextStyle(
      color: Color(0xFF696969),
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    hintStyle: TextStyle(
      color: Color(0xFFCFCFCF),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF39C622), width: 1.0),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFC2534C), width: 1.0),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF2A2A2A), width: 1.0),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFCFCFCF), width: 1.0),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFC2534C), width: 1.0),
    ),
  );
}