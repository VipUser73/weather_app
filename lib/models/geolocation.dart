import 'package:geolocator/geolocator.dart';

class Geolocation {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low)
          .timeout(const Duration(seconds: 15));
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      throw "Wrong: $e";
    }
  }
}
