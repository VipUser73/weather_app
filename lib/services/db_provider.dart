import 'dart:io';
import 'package:flutter_app/models/cities_model.dart';
import 'package:flutter_app/models/weather_model.dart';
import 'package:flutter_app/services/weather_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  Database? _database;
  List<Cities> citiesFromDB = [];
  List<WeatherModel> weatherFavList = [];

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "Cities.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE CITIES_LIST ("
          "id INTEGER PRIMARY KEY,"
          "city TEXT,"
          "lon DOUBLE,"
          "lat DOUBLE"
          ")");
    });
  }

  addCity(Cities value) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT INTO CITIES_LIST(city, lon, lat)"
        "VALUES(?, ?, ?)",
        [value.city, value.lon, value.lat]);
    getWeatherByCityName(value);
    return raw;
  }

  Future<WeatherModel> getWeatherByCityName(Cities currentCity) async {
    final weatherByCityName = await WeaherApi()
        .getWeather(currentCity.city, currentCity.lon, currentCity.lat);
    return weatherByCityName;
  }

  Future<List<Cities>> getFavCitiesList() async {
    final db = await database;
    var res = await db.query("CITIES_LIST");
    citiesFromDB = res.map((e) => Cities.fromDB(e)).toList();
    return citiesFromDB;
  }

  Future<List<WeatherModel>> getFavWeatherList() async {
    await getFavCitiesList();
    weatherFavList = await Future.wait(citiesFromDB
        .map((e) => WeaherApi().getWeather(e.city, e.lon, e.lat))
        .toList());
    return weatherFavList;
  }

  deleteCity(String _cityName) async {
    final db = await database;
    return db.delete("CITIES_LIST", where: "city = ?", whereArgs: [_cityName]);
  }
}
