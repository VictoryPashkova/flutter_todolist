import 'package:flutter/material.dart';
import '../features/log_in/presentation/pages/log_in_page.dart';
export 'home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return const LogInMainPage();
      },
    );
  }
}
