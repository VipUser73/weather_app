import 'dart:convert';
import 'package:flutter_app/api/forecast_api.dart';
import 'package:http/http.dart' as http;

class WeaherAPI {
  Future<ForecastApi> getCurrentWeather(double lat, double lon) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=1369dd6b5ae78fc9952261ab9aa236b4&units=metric");
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    return ForecastApi.fromJson(body);
  }
}

class Constants {
  static const String appID = "1369dd6b5ae78fc9952261ab9aa236b4";
  static const String urlDomain = "api.openweathermap.org";
  static const String forecastPath = "/data/2.5/onecall";
  static const String iconPath = "https://api.openweathermap.org/img/w/";
}
