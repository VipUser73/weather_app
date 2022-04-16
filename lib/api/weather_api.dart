import 'dart:convert';
import 'dart:developer';
import 'package:flutter_app/utilities/geolocation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/forecast_daily.dart';
import 'package:flutter_app/utilities/constants.dart';

class WeatherApi {
  Future<Forecast> fetchWeatherForecast({String? cityName}) async {
    Geolocation geolocation = Geolocation();
    await geolocation.getCurrentLocation();
    Map<String, String>? parameters;
    if (cityName != null) {
      var queryParameters = {
        "APPID": Constants.appID,
        "units": "metric",
        "q": cityName,
      };
      parameters = queryParameters.cast<String, String>();
    } else {
      var queryParameters = {
        "APPID": Constants.appID,
        "units": "metric",
        "lat": geolocation.latitude.toString(),
        "lon": geolocation.longitude.toString(),
      };
      parameters = queryParameters;
    }
    var uri =
        Uri.https(Constants.urlDomain, Constants.forecastPath, parameters);
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
