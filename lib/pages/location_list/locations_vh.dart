import 'package:flutter/material.dart';

class LocationCard {
  final String imagePath;
  final String location;
  final String mainWeather;
  final String temperatureNow;
  final String temperatureMin;
  final String temperatureMax;

  LocationCard({
    required this.temperatureNow,
    required this.imagePath,
    required this.location,
    required this.mainWeather,
    required this.temperatureMin,
    required this.temperatureMax,
  });
}

class LocationVH extends StatelessWidget {
  const LocationVH({Key? key, required this.item}) : super(key: key);

  final LocationCard item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.headline1;
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, '/location');
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        //shadowColor: Colors.white,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    item.location,
                    style: titleTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13, top: 4),
                  child: Text(
                    "${item.temperatureNow}°",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 53,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 19),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.mainWeather,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Image.network(
                    item.imagePath,
                    color: Colors.grey[700],
                  ),
                  Text(
                    "H: ${item.temperatureMax}° L: ${item.temperatureMin}°",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
