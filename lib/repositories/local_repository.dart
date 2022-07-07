import 'dart:convert';
import 'package:flutter_app/models/weather_model.dart';
import 'package:flutter_app/services/db_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/cities_model.dart';

class LocalRepository {
  LocalRepository(this._dbProvider);
  final DBProvider _dbProvider;
  List<Cities> citiesFromJson = [];
  List<WeatherModel> weatherFavList = [];

  Future<List<Cities>> getCitiesList() async {
    var response = await rootBundle.loadString('assets/city_list.json');
    final data = await jsonDecode(response) as List<dynamic>;
    citiesFromJson = data
        .map((dynamic e) => Cities.fromJson(e as Map<String, dynamic>))
        .toList();
    return citiesFromJson;
  }

  Future<List<WeatherModel>> getFavWeatherList() async {
    weatherFavList = await _dbProvider.getFavWeatherList();
    return weatherFavList;
  }

  Future<void> addCity(Cities value) async {
    await _dbProvider.addCity(value);
  }

  Future<void> deleteCity(String _cityName) async {
    await _dbProvider.deleteCity(_cityName);
  }
}
