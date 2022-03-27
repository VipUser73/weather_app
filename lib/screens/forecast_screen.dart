import 'package:flutter/material.dart';
import 'package:flutter_app/api/weather_api.dart';
import 'package:flutter_app/data/location_card.dart';
import 'package:flutter_app/models/forecast_daily.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  late Future<Forecast> forecastObject;
  final String _cityName = "London";

  @override
  void initState() {
    super.initState();
    forecastObject = WeatherApi().forecastCity(cityName: _cityName);

    // forecastObject.then((weather) {
    //   print(weather.list![0].weather![0].main);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        FutureBuilder<Forecast>(
          future: forecastObject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  CityView(snapshot: snapshot),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
