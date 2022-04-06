import 'package:flutter/material.dart';
import 'package:flutter_app/api/weather_api.dart';
import 'location_list/location_page.dart';

class MyLocations extends StatefulWidget {
  const MyLocations({Key? key}) : super(key: key);

  @override
  State<MyLocations> createState() => _MyLocationsState();
}

class _MyLocationsState extends State<MyLocations> {
  void getLocationData() async {
    var weatherInfo = await WeatherApi().fetchWeatherForecast();

    if (weatherInfo == null) {
      print("WeatherInfo was null: $weatherInfo");
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationPage(locationWeather: weatherInfo);
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
