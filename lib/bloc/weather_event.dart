import 'package:flutter_app/models/weather_model.dart';

abstract class WeatherEvent {}

class LoadingForecastEvent extends WeatherEvent {}

class GoToLocationsEvent extends WeatherEvent {}

class LoadingCityEvent extends WeatherEvent {}

class GoToInitialPageEvent extends WeatherEvent {
  final int page;
  GoToInitialPageEvent(this.page);
}

class SearchCityEvent extends WeatherEvent {
  final String cityName;
  SearchCityEvent(this.cityName);
}

class UpdateCitiesCardEvent extends WeatherEvent {
  final List<WeatherModel> weatherFavList;
  UpdateCitiesCardEvent({this.weatherFavList = const []});
}

class DeleteCityEvent extends WeatherEvent {
  final String cityName;
  DeleteCityEvent(this.cityName);
}

class LoadedForecastEvent extends WeatherEvent {
  final List<WeatherModel> weatherFavList;
  LoadedForecastEvent({this.weatherFavList = const []});
}
