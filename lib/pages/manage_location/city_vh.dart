import 'package:flutter/material.dart';
import 'package:flutter_app/api/forecast_api.dart';
import '../../api/constants.dart';
import '../weather_forecast/forecast_page.dart';

class CityVH extends StatelessWidget {
  const CityVH(
      {Key? key,
      required this.cityWeather,
      required this.onDismissed,
      required this.page})
      : super(key: key);
  final ForecastApi cityWeather;
  final ValueChanged<ForecastApi> onDismissed;
  final ValueChanged<ForecastApi> page;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var icon = Constants.iconPath + cityWeather.icon;
    var cityName = cityWeather.name;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDismissed(cityWeather),
        child: GestureDetector(
          onTap: () => page(cityWeather),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.blue.shade200,
            shadowColor: Colors.blue,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cityName,
                          maxLines: 1,
                        ),
                        Text(
                          cityWeather.description,
                          style: theme.textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Image.network("$icon.png"),
                      const SizedBox(width: 10),
                      Text(
                        "${cityWeather.temp}°C",
                        style: theme.textTheme.headline1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.centerRight,
          child: const Icon(Icons.delete_sweep, color: Colors.white),
        ),
      ),
    );
  }
}
