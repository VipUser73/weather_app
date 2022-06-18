import 'dart:convert';
import 'package:flutter_app/models/forecast_api.dart';
import 'package:http/http.dart' as https;

class WeaherProvider {
  Future<ForecastApi> getWeather(double lat, double lon) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=1369dd6b5ae78fc9952261ab9aa236b4&units=metric");
    final response = await https.get(url);
    var body = jsonDecode(response.body);
    return ForecastApi.fromJson(body);
  }
}
