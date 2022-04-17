import 'package:flutter/material.dart';
import '../models/forecast_full.dart';
import 'location_list/location_page.dart';
import '../models/formatted_date.dart';

class WeatherNow extends StatelessWidget {
  final AsyncSnapshot<Forecast> snapshot;
  const WeatherNow({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var dateFromApi =
        (snapshot.data?.current?.dt)! + (snapshot.data?.timezoneOffset)!;
    var icon = snapshot.data?.current?.getIconUrl();
    //var city = snapshot.data?.city?.name;
    var main = snapshot.data?.current?.weather![0].main;
    var tempNow = snapshot.data?.current?.temp?.toStringAsFixed(0);
    var wind = snapshot.data?.current?.windSpeed;
    var pop = snapshot.data?.hourly![0].pop;
    var pressure = snapshot.data?.current?.pressure;
    var humidity = snapshot.data?.current?.humidity;

    var dateForm = DateTime.fromMillisecondsSinceEpoch(dateFromApi * 1000);

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
            Text("Москва", style: theme.textTheme.headline1),
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
              scale: 0.4,
            ),
            Column(
              children: [
                Text(FormattedDate.getFormattedDate(dateForm),
                    style: theme.textTheme.headline1),
                Text("$tempNow°",
                    style: theme.textTheme.headline1?.copyWith(fontSize: 70)),
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

    // return ListView.separated(
    //   separatorBuilder: (context, index) => const SizedBox(width: 8),
    //   itemCount: snapshot.data!.list!.length,
    //   itemBuilder: (context, index) => LocationVH(item: items[index]),
    // );
  }
}
