import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/location_list.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:flutter_app/data/location_card.dart';
import '../screens/forecast_screen.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late String cityName1;
  final Color backgroundColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.headline1;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        title: const Text("This is Sparta!!!"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, '/location');
                  },
                  child: const Icon(
                    Icons.more_horiz_rounded,
                    size: 29,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Weather',
              style: titleTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search for a city or airport',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) {
                  cityName1 = value;
                },
              ),
            ),
            const ForecastScreen(),
          ],
        ),
      ),
    );
  }
}
