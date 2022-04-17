import 'package:flutter/material.dart';
import 'package:flutter_app/models/forecast_full.dart';

class WeatherHourly extends StatelessWidget {
  final AsyncSnapshot<Forecast> snapshot;
  const WeatherHourly({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 0),
            itemCount: snapshot.data!.hourly!.length,
            itemBuilder: (context, index) => SizedBox(
              width: MediaQuery.of(context).size.width / 4.6,
              height: 150,
              child: Column(
                children: [
                  Text("${snapshot.data?.hourly![index].dt}",
                      style: theme.textTheme.headline1),
                  Image.network(
                      "https://api.openweathermap.org/img/w/${snapshot.data?.hourly![index].weather![0].icon}.png"),
                  Text(
                      "${snapshot.data?.hourly![index].temp?.toStringAsFixed(0)}°/${snapshot.data?.hourly![index].feelsLike?.toStringAsFixed(0)}°",
                      style: theme.textTheme.headline1),
                  Text(
                      "${((snapshot.data?.hourly![index].pop)! * 100).toStringAsFixed(0)}% rain",
                      style: theme.textTheme.headline1),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
