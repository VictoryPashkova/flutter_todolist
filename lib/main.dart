import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'internal/application.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MyApp(),
    ),
  );
}
