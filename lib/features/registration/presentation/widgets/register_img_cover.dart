import 'package:flutter/material.dart';

class RegistrationImgCover extends StatelessWidget {
  const RegistrationImgCover({
    super.key,
  });

  static const String backgroundImgPath = 'assets/images/background_image.png';

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Image.asset(
        backgroundImgPath,
        fit: BoxFit.cover,
      ),
    );
  }
}
