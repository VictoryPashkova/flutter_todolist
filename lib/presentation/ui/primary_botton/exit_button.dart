import 'package:flutter/material.dart';
import '../../home.dart';

export 'exit_button.dart';

class ExitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      },
      child: Container(
        width: 42,
        height: 42,
        margin: EdgeInsets.all(12),
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
        child: Icon(Icons.exit_to_app, size: 18),
      ),
    );
  }
}
