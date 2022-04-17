import 'dart:convert';
import 'dart:developer';
import 'package:flutter_app/models/geolocation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/forecast_full.dart';
import 'package:flutter_app/models/constants.dart';

class WeatherApi {
  Future<Forecast> fetchWeatherForecast({String? cityName}) async {
    Geolocation geolocation = Geolocation();
    await geolocation.getCurrentLocation();
    var queryParameters = {
      "exclude": "minutely,alerts",
      "APPID": Constants.appID,
      "units": "metric",
      "lat": geolocation.latitude.toString(),
      "lon": geolocation.longitude.toString(),
    };
    var uri =
        Uri.https(Constants.urlDomain, Constants.forecastPath, queryParameters);
    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    print('response: ${response.body}');

    if (response.statusCode == 200) {
      return Forecast.fromJson(json.decode(response.body));
    } else {
      return Future.error('Error response');
    }
  }
}
