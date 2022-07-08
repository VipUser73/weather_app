import 'package:flutter/material.dart';
import 'package:flutter_app/pages/weather_forecast/widgets/buttons.dart';
import 'package:flutter_app/pages/weather_forecast/widgets/page_view.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({Key? key}) : super(key: key);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ButtonForecast(),
              PageViewWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
