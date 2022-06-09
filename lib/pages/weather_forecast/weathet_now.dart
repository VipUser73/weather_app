import 'package:flutter/material.dart';
import '../../api/constants.dart';
import '../../api/forecast_api.dart';
import '../Manage_location/locations_page.dart';

class WeatherNow extends StatelessWidget {
  const WeatherNow({Key? key, required this.item}) : super(key: key);
  final ForecastApi item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var cityName = item.name;
    var dateFromApi = (item.daily[0].dt);
    var icon = Constants.iconPath + item.icon;
    var description = item.description;
    var tempNow = item.temp;
    var wind = item.wind;
    var pop = item.hourly[0].pop;
    var pressure = item.pressure;
    var humidity = item.humidity;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => const LocationsPage());
                Navigator.push(context, route);
              },
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
            Text(cityName, style: theme.textTheme.headline1),
            SizedBox(width: 60),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              "$icon.png",
              scale: 0.4,
            ),
            Column(
              children: [
                Text(dateFromApi, style: theme.textTheme.headline1),
                Text("$tempNow°",
                    style: theme.textTheme.headline1?.copyWith(fontSize: 70)),
                Text(description, style: theme.textTheme.headline1),
              ],
            ),
          ],
        ),
        const Divider(
          height: 20,
          thickness: 3,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
          padding: const EdgeInsets.only(top: 12, left: 31.67, right: 20),
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
