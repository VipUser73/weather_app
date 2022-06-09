import 'package:flutter/material.dart';
import 'package:flutter_app/api/forecast_api.dart';
import '../../api/constants.dart';
import '../../models/formatted_date.dart';

class WeatherHourly extends StatelessWidget {
  const WeatherHourly({Key? key, required this.item}) : super(key: key);
  final List<Hourly> item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: item.length,
        itemBuilder: (context, index) {
          var dateFromApi = (item[index].hour);
          var icon = Constants.iconPath + item[index].icon;
          var tempHourly = item[index].temp;
          var rain = item[index].pop;
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
                  Text("$dateFromApi", style: theme.textTheme.headline1)
                ],
                Image.network("$icon.png"),
                Text("$tempHourly°", style: theme.textTheme.headline1),
                Text("${(rain * 100).toStringAsFixed(0)}% rain",
                    style: theme.textTheme.headline1),
              ],
            ),
          );
        },
      ),
    );
  }
}
