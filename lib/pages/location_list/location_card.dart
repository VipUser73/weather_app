import 'package:flutter/material.dart';
import 'package:flutter_app/models/forecast_daily.dart';
import 'package:flutter_app/pages/location_list/locations_vh.dart';

class LocationCard {
  final String imagePath;
  final String location;
  final String mainWeather;
  final String temperatureNow;
  final String temperatureMin;
  final String temperatureMax;

  LocationCard({
    required this.temperatureNow,
    required this.imagePath,
    required this.location,
    required this.mainWeather,
    required this.temperatureMin,
    required this.temperatureMax,
  });
}

class CityView extends StatelessWidget {
  final AsyncSnapshot<Forecast> snapshot;
  const CityView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var icon = snapshot.data?.list![0].getIconUrl();
    var city = snapshot.data?.city?.name;
    var main = snapshot.data?.list![0].weather![0].main;
    var tempNow = snapshot.data?.list![0].temp?.day?.toStringAsFixed(0);
    var tempMin = snapshot.data?.list![0].temp?.min?.toStringAsFixed(0);
    var tempMax = snapshot.data?.list![0].temp?.max?.toStringAsFixed(0);

    final items = [
      LocationCard(
          imagePath: '$icon',
          location: '$city',
          mainWeather: '$main',
          temperatureNow: '$tempNow',
          temperatureMax: '$tempMax',
          temperatureMin: '$tempMin'),
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      children: items.map((e) => LocationVH(item: e)).toList(),
    );

    // return ListView.separated(
    //   separatorBuilder: (context, index) => const SizedBox(width: 8),
    //   itemCount: snapshot.data!.list!.length,
    //   itemBuilder: (context, index) => LocationVH(item: items[index]),
    // );
  }
}
