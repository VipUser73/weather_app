import 'package:flutter/material.dart';
import '../api/weather_api.dart';
import '../models/forecast_daily.dart';
import 'weathet_now.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late Future<Forecast> forecastObject;
  final String _cityName = 'Ulyanovsk';

  @override
  void initState() {
    super.initState();
    forecastObject = WeatherApi().fetchWeatherForecast(cityName: _cityName);
    //forecastObject.then((weather) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(98, 184, 246, 1),
              Color.fromRGBO(44, 121, 193, 1)
            ],
          ),
        ),
        child: SafeArea(
          child: FutureBuilder<Forecast>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        WeatherNow(snapshot: snapshot),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }

  // void getUpdate() {
  //   String currentCityName = 'London';
  //   WeatherApi().fetchWeatherForecast();
  //   print("setNewCityName: $currentCityName");
  // }
}
