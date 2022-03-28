import 'package:flutter/material.dart';
import 'package:flutter_app/api/weather_api.dart';
import 'location_card.dart';
import 'package:flutter_app/models/forecast_daily.dart';

class ForecastScreen extends StatefulWidget {
  ForecastScreen(this.currentCityName, {Key? key}) : super(key: key);
  final String currentCityName;

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  late Future<Forecast> forecastObject;
  //late final String cityName1 = "Moscow";

  // @override
  // void initState() {
  //   super.initState();
  //   print("initState: ${widget.currentCityName}");
  //   forecastObject =
  //       WeatherApi().forecastCity(cityName: widget.currentCityName);

  // forecastObject.then((weather) {
  //   print(weather.list![0].weather![0].main);
  // });
  //}

  @override
  Widget build(BuildContext context) {
    print("build: ${widget.currentCityName}");
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        FutureBuilder<Forecast>(
          future: loadCity(),
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

  Future<Forecast> loadCity() =>
      WeatherApi().forecastCity(cityName: widget.currentCityName);
}
