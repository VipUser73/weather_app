import 'package:flutter/material.dart';
import 'package:flutter_app/models/forecast_daily.dart';
import 'package:flutter_app/pages/location_list/locations_vh.dart';

class LocationCard {
  final String imagePath;
  final textTitle;
  final String temperatureNow;

  LocationCard(
      {required this.temperatureNow,
      required this.imagePath,
      required this.textTitle});
}

class CityView extends StatelessWidget {
  final AsyncSnapshot<Forecast> snapshot;
  const CityView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var city = snapshot.data?.city?.name;
    var country = snapshot.data?.city?.country;
    final items = [
      LocationCard(
          imagePath: 'assets/images/cloudy.png',
          textTitle: '$city',
          temperatureNow: '21°'),
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      children: items.map((e) => LocationVH(item: e)).toList(),
    );
  }
}
