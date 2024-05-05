import 'package:flutter/material.dart';

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
