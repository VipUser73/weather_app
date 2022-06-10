import 'package:flutter/material.dart';
import '../../api/constants.dart';
import '../../api/forecast_api.dart';

class Weather7days extends StatelessWidget {
  const Weather7days({Key? key, required this.item}) : super(key: key);
  final List<Daily> item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.zero,
      height: MediaQuery.of(context).size.height / 3,
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
                String dateFromApi = (item[index].dt);
                String icon = Constants.iconPath + item[index].icon;
                int tempMin = item[index].tempMin;
                int tempMax = item[index].tempMax;
                double rain = item[index].pop;
                return Row(
                  children: [
                    Expanded(
                      child: Text(dateFromApi,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline1),
                    ),
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        "$icon.png",
                        alignment: Alignment.center,
                        width: 35,
                        height: 35,
                        fit: BoxFit.none,
                      ),
                    ),
                    Expanded(
                      child: Text("${(rain * 100).toStringAsFixed(0)}% rain",
                          textAlign: TextAlign.left,
                          style: theme.textTheme.headline1),
                    ),
                    Expanded(
                      child: Text(" $tempMin°/$tempMax°",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline1),
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
