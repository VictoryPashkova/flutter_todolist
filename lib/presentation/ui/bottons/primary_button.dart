import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnText;
  final bool isValid;

  const PrimaryButton({
    required this.onPressed,
    required this.btnText,
    required this.isValid,
    Key? key,
  }) : super(key: key);

  static const Color focusedColor = Color(0xFF2A2A2A);
  static const Color enabledBtnColor = Color(0xFFEBEBEB);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: isValid ? onPressed : null,
        child: Text(
          btnText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
