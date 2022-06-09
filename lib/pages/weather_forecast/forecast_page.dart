import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_app/pages/weather_forecast/weather_7days.dart';
import 'package:flutter_app/pages/weather_forecast/weather_hourly.dart';
import '../../api/forecast_api.dart';
import '../../models/weather.dart';
import 'weathet_now.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key, required this.initialPage}) : super(key: key);
  final int initialPage;

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late final _controller;
  List<ForecastApi> _citiesList = [];
  bool _isLoading = true;
  @override
  void initState() {
    _controller = PageController(initialPage: widget.initialPage);
    getFavCitiesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          child: Column(
            children: [
              Expanded(
                child: _isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : (_citiesList.isEmpty)
                        ? const Center(
                            child: Text(
                                "There are no cities here yet.\nTap the button below to add."),
                          )
                        : PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: _controller,
                            itemCount: _citiesList.length,
                            itemBuilder: (context, index) {
                              final cityWeather = _citiesList[index];
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    WeatherNow(item: cityWeather),
                                    WeatherHourly(item: cityWeather.hourly),
                                    Weather7days(item: cityWeather.daily),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: _citiesList.length,
                      effect: ScrollingDotsEffect(
                        dotColor: Colors.blue.shade400,
                        activeDotColor: Colors.white,
                        dotWidth: 10,
                        dotHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getFavCitiesList() async {
    final items = await WeatherService().getFavWeatherList();
    setState(() {
      _citiesList = items;
      _isLoading = false;
    });
  }
}
