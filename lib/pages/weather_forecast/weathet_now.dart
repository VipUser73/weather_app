import 'package:flutter/material.dart';
import '../../api/constants.dart';
import '../../api/forecast_api.dart';

class WeatherNow extends StatelessWidget {
  const WeatherNow({Key? key, required this.item}) : super(key: key);
  final ForecastApi item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String cityName = item.name;
    String dateFromApi = (item.daily[0].dt);
    String icon = Constants.iconPath + item.icon;
    String description = item.description;
    int tempNow = item.temp;
    int wind = item.wind;
    double pop = item.hourly[0].pop;
    int pressure = item.pressure;
    int humidity = item.humidity;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(cityName,
            style: theme.textTheme.headline1?.copyWith(fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.network(
                "$icon.png",
                width: 120,
                height: 120,
                scale: 0.4,
              ),
            ),
            Column(
              children: [
                Text(dateFromApi, style: theme.textTheme.headline1),
                Text("$tempNow°",
                    style: theme.textTheme.headline1?.copyWith(fontSize: 60)),
                Text(description, style: theme.textTheme.headline1),
              ],
            ),
          ],
        ),
        const Divider(
          height: 20,
          thickness: 2,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/icons/wind.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("$wind m/s\nWind", style: theme.textTheme.bodyText1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/icons/rain.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("${(pop * 100).round()}%\nChance of rain",
                      style: theme.textTheme.bodyText1),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 31.67, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/icons/pressure.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("$pressure hPa\nPressure",
                      style: theme.textTheme.bodyText1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/icons/humidity.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 26),
                    child: Text("$humidity% \nHumidity",
                        style: theme.textTheme.bodyText1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
