import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_style/dart_style.dart';

export 'register_img_cover.dart';

class RegistrationImgCover extends StatelessWidget {
  const RegistrationImgCover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Image.asset(
        'assets/images/background_image.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
