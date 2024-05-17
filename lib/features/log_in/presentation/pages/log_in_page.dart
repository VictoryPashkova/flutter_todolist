import 'package:flutter/material.dart';
import '../widgets/log_in_form.dart';

class LogInMainPage extends StatelessWidget {
  const LogInMainPage({super.key});

  static const String backgroundImgPath = 'assets/images/background_image.png';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset(
                backgroundImgPath,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              bottom: false,
              top: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.1,
                      screenHeight * 0.05,
                      screenWidth * 0.1,
                      screenHeight * 0.15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenHeight * 0.03),
                        topRight: Radius.circular(screenHeight * 0.03),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        const LogInForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
