import 'package:flutter/material.dart';
import 'package:flutter_app/api/weather_api.dart';
import '../../models/forecast_daily.dart';
import '../../utilities/city_list.dart';
import 'location_card.dart';

class LocationPage extends StatefulWidget {
  final locationWeather;
  LocationPage({this.locationWeather});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Color backgroundColor = Colors.black;
  late Future<Forecast> forecastObject;

  String currentCityName = '';
  Future<Forecast> loadCity() =>
      WeatherApi().fetchWeatherForecast(cityName: currentCityName);

  @override
  void initState() {
    super.initState();
    if (widget.locationWeather != null) {
      forecastObject = WeatherApi().fetchWeatherForecast();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.headline1;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        toolbarHeight: 0,
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
            //SearchField(currentCityName, setNewCityName),
            Padding(
              padding: const EdgeInsets.all(8),
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
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                onSubmitted: setNewCityName,
              ),
            ),
            Visibility(
              visible: currentCityName.isEmpty,
              child: FutureBuilder<Forecast>(
                future: loadCity(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CityView(snapshot: snapshot);
                  } else {
                    return const Center(
                      child: Text(
                        "City not found.",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  }
                },
              ),
            ),
            Visibility(
              visible: currentCityName.isNotEmpty,
              child: FutureBuilder<CityList>(
                future: getCityList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CityListView(snapshot: snapshot);
                  } else {
                    return const Center(
                      child: Text(
                        "City not found.",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setNewCityName(String cityName) {
    print("setNewCityName: $cityName");
    setState(() {
      currentCityName = cityName;
    });
  }
}
