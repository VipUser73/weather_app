import 'package:geolocator/geolocator.dart';

class Geolocation {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();

      return;
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();

      return;
    } else {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print("latitude = ${position.latitude}");
      print("longitude= ${position.longitude}");
      latitude = position.latitude;
      longitude = position.longitude;
    }
  }
}
