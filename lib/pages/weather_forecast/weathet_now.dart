import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/forecast_api.dart';

class WeatherNow extends StatelessWidget {
  const WeatherNow({Key? key, required this.item}) : super(key: key);
  final ForecastApi item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(item.name,
            style: theme.textTheme.headline1?.copyWith(fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SvgPicture.asset(
                "assets/icons/conditions/${item.icon}.svg",
                width: 100,
                height: 100,
              ),
            ),
            Column(
              children: [
                Text(item.daily[0].dt, style: theme.textTheme.headline1),
                Text("${item.temp}",
                    style: theme.textTheme.headline1?.copyWith(fontSize: 60)),
                Text(item.description, style: theme.textTheme.headline1),
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
                  Text("${item.wind} m/s\nWind",
                      style: theme.textTheme.bodyText1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/icons/rain.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("${(item.hourly[0].pop * 100).round()}%\nChance of rain",
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
                  Text("${item.pressure} hPa\nPressure",
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
                    child: Text("${item.humidity}% \nHumidity",
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
