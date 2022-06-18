import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../services/weather_api_provider.dart';
import '../../models/forecast_api.dart';

class Weather7days extends StatelessWidget {
  const Weather7days({Key? key, required this.item}) : super(key: key);
  final List<Daily> item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.zero,
      height: MediaQuery.of(context).size.height / 2.8,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text("Forcats for 7 Days",
                style: theme.textTheme.headline1, textAlign: TextAlign.center),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: item.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Text(item[index].dt,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.headline1),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: SvgPicture.asset(
                          "assets/icons/conditions/${item[index].icon}.svg",
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                          "${(item[index].pop * 100).toStringAsFixed(0)}% rain",
                          textAlign: TextAlign.left,
                          style: theme.textTheme.headline1),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            "${item[index].tempMin}°/${item[index].tempMax}°",
                            textAlign: TextAlign.left,
                            style: theme.textTheme.headline1),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
