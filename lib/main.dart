import 'package:Meteo/screens/controllers/SplashController.dart';
import 'package:Meteo/theme/AppTheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MeteoApp());
}

class MeteoApp extends StatelessWidget {
  const MeteoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      home: const SplashViewController(),
    );
  }
}

