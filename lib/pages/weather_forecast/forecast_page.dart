import 'package:flutter/material.dart';
import 'package:flutter_app/pages/manage_location/locations_page.dart';
import 'package:flutter_app/pages/weather_forecast/widgets/page_view.dart';

class ForecastPage extends StatelessWidget {
  ForecastPage({Key? key}) : super(key: key);

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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const LocationsPage()));
                  },
                  child: const Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              const PageViewWidget()
            ],
          ),
        ),
      ),
    );
  }
}
