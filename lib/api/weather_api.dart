import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/forecast_daily.dart';
import 'package:flutter_app/utilities/constants.dart';

class WeatherApi {
  Future<Forecast> forecastCity({required String cityName}) async {
    var queryParameters = {
      "APPID": Constants.appID,
      "units": "metric",
      "q": cityName,
    };
    var uri =
        Uri.https(Constants.urlDomain, Constants.forecastPath, queryParameters);
    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    //print('response: ${response.body}');

    if (response.statusCode == 200) {
      return Forecast.fromJson(json.decode(response.body));
    } else {
      return Future.error('Error response');
    }
  }
}
