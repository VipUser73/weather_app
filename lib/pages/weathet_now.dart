import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../models/forecast_daily.dart';
import 'location_list/location_page.dart';
import '../utilities/formatted_date.dart';

class WeatherNow extends StatelessWidget {
  final AsyncSnapshot<Forecast> snapshot;
  const WeatherNow({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var dateFromApi = snapshot.data?.list![0].dt;
    var icon = snapshot.data?.list![0].getIconUrl();
    var city = snapshot.data?.city?.name;
    var main = snapshot.data?.list![0].weather![0].main;
    var tempNow = snapshot.data?.list![0].temp?.day?.toStringAsFixed(0);
    var tempMin = snapshot.data?.list![0].temp?.min?.toStringAsFixed(0);
    var tempMax = snapshot.data?.list![0].temp?.max?.toStringAsFixed(0);
    var wind = snapshot.data?.list![0].speed;
    var pop = snapshot.data?.list![0].pop;
    var pressure = snapshot.data?.list![0].pressure;
    var humidity = snapshot.data?.list![0].humidity;

    var dateForm = DateTime.fromMillisecondsSinceEpoch(dateFromApi! * 1000);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (context) => LocationPage());
                Navigator.push(context, route);
              },
              child: const Icon(
                Icons.add,
                size: 29,
                color: Colors.white,
              ),
            ),
            Text("$city", style: theme.textTheme.headline1),
            TextButton(
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (context) => LocationPage());
                Navigator.push(context, route);
              },
              child: const Icon(
                Icons.more_vert,
                size: 29,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              "$icon",
              scale: 0.3,
            ),
            Column(
              children: [
                Text(FormattedDate.getFormattedDate(dateForm),
                    style: theme.textTheme.headline1),
                Text("$tempNow°", style: theme.textTheme.headline1),
                Text("$main", style: theme.textTheme.headline1),
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
                  Text("${(pop! * 100).round()}%\nChance of rain",
                      style: theme.textTheme.bodyText1),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 31.67, right: 20),
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
                    padding: const EdgeInsets.only(right: 27),
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

    // return ListView.separated(
    //   separatorBuilder: (context, index) => const SizedBox(width: 8),
    //   itemCount: snapshot.data!.list!.length,
    //   itemBuilder: (context, index) => LocationVH(item: items[index]),
    // );
  }
}
