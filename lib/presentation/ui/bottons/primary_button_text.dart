import 'package:flutter/material.dart';

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
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
