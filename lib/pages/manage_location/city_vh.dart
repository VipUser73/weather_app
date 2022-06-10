import 'package:flutter/material.dart';
import '../../api/constants.dart';
import '../../api/forecast_api.dart';

class CityVH extends StatelessWidget {
  const CityVH(
      {Key? key,
      required this.cityWeather,
      required this.onDismissed,
      required this.page})
      : super(key: key);
  final ForecastApi cityWeather;
  final ValueChanged<ForecastApi> onDismissed;
  final ValueChanged<ForecastApi> page;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String icon = Constants.iconPath + cityWeather.icon;
    String cityName = cityWeather.name;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDismissed(cityWeather),
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.centerRight,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: GestureDetector(
          onTap: () => page(cityWeather),
          child: Card(
            margin: EdgeInsets.zero,
            color: const Color.fromARGB(255, 50, 100, 160),
            shadowColor: Colors.blueGrey,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cityName,
                            maxLines: 1, style: theme.textTheme.headline1),
                        Text(
                          cityWeather.description,
                          style: theme.textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white38),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Image.network(
                        "$icon.png",
                        scale: 0.7,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${cityWeather.temp}°C",
                        style:
                            theme.textTheme.headline1?.copyWith(fontSize: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
