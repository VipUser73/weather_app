import 'package:flutter/material.dart';
import 'package:flutter_app/pages/manage_location/city_vh.dart';
import '../../api/forecast_api.dart';
import '../../models/local.dart';
import '../../models/weather.dart';
import '../weather_forecast/forecast_page.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List<ForecastApi> _citiesList = [];
  bool _isLoading = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    getFavCitiesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.headline1;
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ForecastPage(initialPage: 0)));
                      },
                      child: const Icon(
                        Icons.location_searching,
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
                  'Manage location',
                  style: titleTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: 'Search for a city or airport',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    onSubmitted: setEnteredCity,
                  ),
                ),
                Expanded(
                  child: _isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white))
                      : ListView(children: [
                          ..._citiesList
                              .map((item) => CityVH(
                                  cityWeather: item,
                                  onDismissed: onDismissed,
                                  page: openCity))
                              .toList()
                        ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDismissed(ForecastApi item) {
    setState(() {
      _citiesList.remove(item);
      StorageRepository().saveFavCities(
          _citiesList.map((e) => Cities.fromWeather(e)).toList());
    });
  }

  void openCity(ForecastApi item) {
    final index = _citiesList.indexOf(item);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ForecastPage(initialPage: index)));
  }

  void setEnteredCity(String value) async {
    setState(() {
      _isLoading = true;
    });
    final result = await WeatherService().getWeatherByCityName(value);
    if (result != null &&
        _citiesList.where((e) => e.name == result.name).isEmpty) {
      _citiesList.add(result);
      StorageRepository().saveFavCities(
          _citiesList.map((e) => Cities.fromWeather(e)).toList());
    }
    setState(() {
      _isLoading = false;
      _controller.text = "";
    });
  }

  Future getFavCitiesList() async {
    final items = await WeatherService().getFavWeatherList();
    setState(() {
      _citiesList = items;
      _isLoading = false;
    });
  }
}
