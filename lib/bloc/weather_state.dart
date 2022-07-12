import 'package:flutter_app/models/weather_model.dart';

abstract class WeatherState {
  final List<WeatherModel> weatherFavList;
  final int indexPage;
  WeatherState({this.weatherFavList = const [], this.indexPage = 0});
}

class LoadingForecastState extends WeatherState {}

class LoadingCityState extends WeatherState {}

class CityLoadedState extends WeatherState {}

class ForecastErrorState extends WeatherState {}

class GoToLocationsState extends WeatherState {}

class CityNotFoundState extends WeatherState {}

class CityAlreadyOnListState extends WeatherState {}

class GoToInitialPageState extends WeatherState {
  GoToInitialPageState({required int nPage}) : super(indexPage: nPage);
}

class ForecastLoadedState extends WeatherState {
  ForecastLoadedState({required List<WeatherModel> weatherFavList})
      : super(weatherFavList: weatherFavList);
}
