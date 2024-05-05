import 'package:flutter/material.dart';
import '../widgets/register_form.dart';
export 'registration_main_page.dart';

class RegistrationMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/background_image.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 149,
            left: 0,
            right: 0,
            child: Container(
              width: 375,
              padding: EdgeInsets.fromLTRB(24, 36, 24, 76),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Registration',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  SizedBox(height: 28),
                  RegisterForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
