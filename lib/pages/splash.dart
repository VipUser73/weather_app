import 'package:flutter/material.dart';
import '../models/local.dart';
import 'Manage_location/locations_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: null,
        future: initServices(context),
        builder: (_, __) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(98, 184, 246, 1),
                    Color.fromRGBO(44, 121, 193, 1)
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  "Weather",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        });
  }

  Future initServices(BuildContext context) async {
    return StorageRepository().getCitiesList().then((value) =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LocationsPage())));
  }
}
