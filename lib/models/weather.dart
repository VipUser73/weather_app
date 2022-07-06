// import 'package:flutter_app/bloc/city_bloc.dart';
// import 'package:flutter_app/models/cities_model.dart';
// import 'package:flutter_app/models/weather_model.dart';
// import 'package:flutter_app/services/db.dart';
// import 'package:flutter_app/services/weather_api.dart';

// class WeatherService {
//   static List<WeatherModel> weatherFavList = [];
//   Future<WeatherModel> getWeatherByCityName(Cities currentCity) async {
//     final weatherByCityName =
//         await WeaherProvider().getWeather(currentCity.lon, currentCity.lat);
//     print(weatherByCityName.description);
//     return weatherByCityName;
//   }

//   Future<List<WeatherModel>> getFavWeatherList() async {
//     await WeaherApi().readCities();
//     weatherFavList = await Future.wait(DBProvider.citiesList
//         .map((e) => WeaherProvider().getWeather(e.lon, e.lat))
//         .toList());
//     print("Погода из ДБ: ${weatherFavList[0].description}");
//     return weatherFavList;
//   }
// }
