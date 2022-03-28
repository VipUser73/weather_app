import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'search_feild.dart';
import 'forecast_screen.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Color backgroundColor = Colors.black;
  String currentCityName = 'London';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.headline1;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        title: const Text("This is Sparta!!!"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, '/location');
                  },
                  child: const Icon(
                    Icons.more_horiz_rounded,
                    size: 29,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Weather',
              style: titleTextStyle,
            ),
            SearchField(currentCityName, setNewCityName),
            ForecastScreen(currentCityName),
          ],
        ),
      ),
    );
  }

  void setNewCityName(String cityName) {
    print("setNewCityName: $cityName");
    setState(() {
      currentCityName = cityName;
    });
  }
}
