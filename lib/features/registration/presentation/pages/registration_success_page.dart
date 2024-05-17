import 'package:flutter/material.dart';
import '../../../user_desks/presentation/pages/main_dashboard_page.dart';
import '../../../../presentation/ui/bottons/primary_button.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  static const String registrationSuccessImgPath =
      'assets/images/RegistrationSuccessImg.png';

  void _onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserDashboardPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              registrationSuccessImgPath,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Text(
              'You have been registered!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Outfit',
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.02),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: PrimaryButton(
                btnText: 'Get started',
                onPressed: () => _onPressed(context),
                isValid: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
