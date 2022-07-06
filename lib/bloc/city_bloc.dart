import 'package:flutter_app/models/cities_model.dart';
import 'package:flutter_app/models/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/local_repository.dart';

abstract class CityEvent {}

class SearchCityEvent extends CityEvent {
  final String cityName;
  SearchCityEvent(this.cityName);
}

class UpdateCitiesCardEvent extends CityEvent {
  final List<WeatherModel> weatherFavList;
  UpdateCitiesCardEvent({this.weatherFavList = const []});
}

class DeleteCityEvent extends CityEvent {
  final String cityName;
  DeleteCityEvent(this.cityName);
}

class LoadForecastEvent extends CityEvent {
  final List<WeatherModel> weatherFavList;
  LoadForecastEvent({this.weatherFavList = const []});
}

abstract class CityState {
  final List<WeatherModel> weatherFavList;
  CityState({this.weatherFavList = const []});
}

class CityLoadingState extends CityState {}

class CityLoadedState extends CityState {
  CityLoadedState({required List<WeatherModel> weatherFavList})
      : super(weatherFavList: weatherFavList);
}

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc(this._storageRepository) : super(CityLoadingState()) {
    on<SearchCityEvent>(_addCities);
    on<UpdateCitiesCardEvent>(_updateCities);
    on<DeleteCityEvent>(_deleteCities);
    on<LoadForecastEvent>(_loadForecast);
    _updateListCities();
  }
  final LocalRepository _storageRepository;

  void _addCities(SearchCityEvent event, Emitter<CityState> emit) async {
    try {
      final Cities cityAndCoord = _storageRepository.allCities.firstWhere(
          (e) => e.city.toLowerCase() == event.cityName.toLowerCase());

      if ((_storageRepository.citiesList.where(
              (e) => e.city.toLowerCase() == event.cityName.toLowerCase()))
          .isEmpty) {
        await _storageRepository.addCity(cityAndCoord);
        _updateListCities();
      }
    } catch (error) {
      print('City is not found');
    }
  }

  void _updateCities(
      UpdateCitiesCardEvent event, Emitter<CityState> emit) async {
    emit(CityLoadedState(weatherFavList: event.weatherFavList));
  }

  void _updateListCities() async {
    List<WeatherModel> weatherFavList =
        await _storageRepository.getFavWeatherList();
    add(UpdateCitiesCardEvent(weatherFavList: weatherFavList));
  }

  void _deleteCities(DeleteCityEvent event, Emitter<CityState> emit) async {
    await _storageRepository.deleteCity(event.cityName);
    //emit(CityLoadedState(weatherFavList: event.weatherFavList));
  }

  void _loadForecast(LoadForecastEvent event, Emitter<CityState> emit) async {
    emit(CityLoadedState(weatherFavList: event.weatherFavList));
  }
}
