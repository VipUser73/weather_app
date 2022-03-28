import 'package:flutter/material.dart';
import 'package:flutter_app/pages/location_list/location_page.dart';
import 'package:flutter_app/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: const LocationPage(),
    );
  }
}
