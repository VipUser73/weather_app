import 'dart:async';
import 'package:flutter_app/bloc/weather_event.dart';
import 'package:flutter_app/bloc/weather_state.dart';
import 'package:flutter_app/models/cities_model.dart';
import 'package:flutter_app/models/weather_model.dart';
import 'package:flutter_app/repositories/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeaterBloc extends Bloc<WeatherEvent, WeatherState> {
  WeaterBloc(this._storageRepository) : super(LoadingForecastState()) {
    on<LoadingForecastEvent>(_loadingWeatherList);
    on<GoToLocationsEvent>(_goToLocations);
    on<SearchCityEvent>(_addCities);
    on<UpdateCitiesCardEvent>(_updateCities);
    on<DeleteCityEvent>(_deleteCities);
    on<GoToInitialPageEvent>(_goToInitialPage);
    Timer.periodic(const Duration(seconds: 600), (Timer t) {
      _updateListCities();
    });
  }
  final LocalRepository _storageRepository;

  void _loadingWeatherList(
      LoadingForecastEvent event, Emitter<WeatherState> emit) async {
    try {
      List<WeatherModel> weatherFavList =
          await _storageRepository.getFavWeatherList();
      emit(ForecastLoadedState(weatherFavList: weatherFavList));
    } catch (_) {
      emit(ForecastErrorState());
    }
  }

  void _goToLocations(
      GoToLocationsEvent event, Emitter<WeatherState> emit) async {
    emit(GoToLocationsState());
  }

  void _goToInitialPage(
      GoToInitialPageEvent event, Emitter<WeatherState> emit) async {
    emit(GoToInitialPageState(nPage: event.page));
  }

  void _addCities(SearchCityEvent event, Emitter<WeatherState> emit) async {
    emit(LoadingCityState());

    if (_storageRepository.citiesFromJson.isEmpty) {
      await _storageRepository.getCitiesList();
    }
    if (_storageRepository.weatherFavList.isEmpty) {
      try {
        final Cities cityAndCoord = _storageRepository.citiesFromJson
            .firstWhere(
                (e) => e.city.toLowerCase() == event.cityName.toLowerCase());

        await _storageRepository.addCity(cityAndCoord);
        _updateListCities();
      } catch (_) {
        emit(CityNotFoundState());
      }
    } else {
      try {
        final Cities cityAndCoord = _storageRepository.citiesFromJson
            .firstWhere(
                (e) => e.city.toLowerCase() == event.cityName.toLowerCase());

        if ((_storageRepository.weatherFavList.where((city) =>
            city.name.toLowerCase() == event.cityName.toLowerCase())).isEmpty) {
          await _storageRepository.addCity(cityAndCoord);
          _updateListCities();
        } else {
          _updateListCities();
          emit(CityAlreadyOnListState());
        }
      } catch (_) {
        emit(CityNotFoundState());
      }
    }
  }

  void _updateCities(
      UpdateCitiesCardEvent event, Emitter<WeatherState> emit) async {
    emit(ForecastLoadedState(weatherFavList: event.weatherFavList));
  }

  void _updateListCities() async {
    List<WeatherModel> weatherFavList =
        await _storageRepository.getFavWeatherList();
    add(UpdateCitiesCardEvent(weatherFavList: weatherFavList));
  }

  void _deleteCities(DeleteCityEvent event, Emitter<WeatherState> emit) async {
    await _storageRepository.deleteCity(event.cityName);
    _updateListCities();
  }
}
