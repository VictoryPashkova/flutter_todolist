import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_style/dart_style.dart';
import '../../../../presentation/ui/primary_botton/primary_button_text.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 236,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/RegistrationSuccessImg.png',
                ),
                SizedBox(height: 20),
                Text(
                  'You have been registered!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Outfit',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 128,
            left: 24,
            right: 24,
            child: ElevatedButton(
              onPressed: () {
                print('Go to app link');
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.fromLTRB(12, 16, 12, 16)),
                minimumSize: MaterialStateProperty.all(Size(375, 54)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Color(0xFF2A2A2A)),
              ),
              child: PrimaryButtonText(text: 'Get started'),
            ),
          ),
        ],
      ),
    );
  }
}
