import 'package:flutter/material.dart';
import 'models/theme.dart';
import 'pages/splash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: const SplashScreen(),
    );
  }
}
