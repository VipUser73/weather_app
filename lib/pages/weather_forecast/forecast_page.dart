import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/forecast_api.dart';
import '../../models/weather.dart';
import '../manage_location/locations_page.dart';
import 'weather_7days.dart';
import 'weather_hourly.dart';
import 'weathet_now.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key, required this.initialPage}) : super(key: key);
  final int initialPage;

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late final dynamic _controller;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: TextButton(
                  onPressed: () {
                    openLocations(context);
                  },
                  child: const Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: _isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : (_citiesList.isEmpty)
                        ? Center(
                            child: Text(
                              "The list of cities is empty!\nTo add, click on the icon at the top.",
                              style: titleTextStyle?.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                                PageView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  controller: _controller,
                                  itemCount: _citiesList.length,
                                  itemBuilder: (context, index) {
                                    final cityWeather = _citiesList[index];
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: Column(
                                        children: [
                                          WeatherNow(item: cityWeather),
                                          WeatherHourly(
                                              item: cityWeather.hourly),
                                          Weather7days(item: cityWeather.daily),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
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
                              ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openLocations(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationsPage()),
    );
    getFavCitiesList();
  }

  Future getFavCitiesList() async {
    final items = await WeatherService().getFavWeatherList();
    setState(() {
      _citiesList = items;
      _isLoading = false;
    });
  }
}
