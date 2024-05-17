import 'package:flutter/material.dart';
import 'package:flutter_todolist/features/log_in/presentation/pages/log_in_page.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LogInMainPage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 60,
            ),
          ],
        ),
        child: const Icon(Icons.exit_to_app, size: 18),
      ),
    );
  }
}
