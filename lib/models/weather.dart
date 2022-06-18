import '../services/weather_api_provider.dart';
import 'forecast_api.dart';
import 'local.dart';

class WeatherService {
  Future<ForecastApi?> getWeatherByCityName(String enteredCity) async {
    final cities = await StorageRepository().getCitiesList();
    final enteredCityList = cities
        .where((element) =>
            element.city.toLowerCase() == enteredCity.toLowerCase())
        .toList();
    if (enteredCityList.isEmpty) {
      return null;
    }
    final currentCity = enteredCityList[0];
    final weatherByCityName =
        await WeaherProvider().getWeather(currentCity.lat, currentCity.lon);
    weatherByCityName.name = currentCity.city;
    return weatherByCityName;
  }

  Future<List<ForecastApi>> getFavWeatherList() async {
    final result = await StorageRepository().readFavCities();
    return await Future.wait(result
        .map((e) => getWeatherByCityName(e.city).then((value) => value!))
        .toList());
  }

  Future<List<Cities>> getTipsList([String enteredCity = ""]) async {
    if (enteredCity.isEmpty) {
      return [];
    }
    final cities = await StorageRepository().getCitiesList();
    final matchedCityList = cities
        .where((element) =>
            element.city.toLowerCase().contains(enteredCity.toLowerCase()))
        .toList();
    return matchedCityList;
  }
}
