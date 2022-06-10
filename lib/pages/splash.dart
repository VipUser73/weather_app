import 'package:flutter/material.dart';
import 'package:flutter_app/pages/weather_forecast/forecast_page.dart';
import '../models/local.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: null,
        future: initServices(context),
        builder: (_, __) {
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
              child: const Center(
                  child: CircularProgressIndicator(color: Colors.white)),
            ),
          );
        });
  }

  Future initServices(BuildContext context) async {
    return StorageRepository().getCitiesList().then((value) =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                const ForecastPage(initialPage: 0))));
  }
}
