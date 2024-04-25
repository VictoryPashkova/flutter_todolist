import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_style/dart_style.dart';

export 'primary_button_text.dart';

class PrimaryButtonText extends StatelessWidget {
  final String text;

  const PrimaryButtonText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Outfit',
        color: Colors.white,
      ),
    );
  }
}
