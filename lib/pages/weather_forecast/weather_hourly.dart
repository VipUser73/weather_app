import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/models/forecast_api.dart';

class WeatherHourly extends StatelessWidget {
  const WeatherHourly({Key? key, required this.item}) : super(key: key);
  final List<Hourly> item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 110,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: item.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 4.6,
            height: 150,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (index == 0) ...[
                  Text("Now", style: theme.textTheme.headline1),
                ] else ...[
                  Text("${item[index].hour}", style: theme.textTheme.headline1)
                ],
                SvgPicture.asset(
                  ("assets/icons/conditions/${item[index].icon}.svg"),
                  width: 30,
                  height: 30,
                ),
                Text("${item[index].temp}°", style: theme.textTheme.headline1),
                Text("${(item[index].pop * 100).toStringAsFixed(0)}% rain",
                    style: theme.textTheme.headline1),
              ],
            ),
          );
        },
      ),
    );
  }
}
