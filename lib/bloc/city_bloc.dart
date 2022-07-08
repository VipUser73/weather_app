import 'package:flutter_app/models/cities_model.dart';
import 'package:flutter_app/models/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/local_repository.dart';

abstract class CityEvent {}

class LoadingForecastEvent extends CityEvent {}

class GoToLocationsEvent extends CityEvent {}

class LoadingCityEvent extends CityEvent {}

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

class LoadedForecastEvent extends CityEvent {
  final List<WeatherModel> weatherFavList;
  LoadedForecastEvent({this.weatherFavList = const []});
}

abstract class CityState {
  final List<WeatherModel> weatherFavList;
  CityState({this.weatherFavList = const []});
}

class LoadingForecastState extends CityState {}

class LoadingCityState extends CityState {}

class CityLoadedState extends CityState {}

class ForecastErrorState extends CityState {}

class GoToLocationsState extends CityState {}

class ForecastLoadedState extends CityState {
  ForecastLoadedState({required List<WeatherModel> weatherFavList})
      : super(weatherFavList: weatherFavList);
}

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc(this._storageRepository) : super(LoadingForecastState()) {
    on<LoadingForecastEvent>(_loadingWeatherList);
    on<GoToLocationsEvent>(_goToLocations);
    on<SearchCityEvent>(_addCities);
    on<UpdateCitiesCardEvent>(_updateCities);
    on<DeleteCityEvent>(_deleteCities);
  }
  final LocalRepository _storageRepository;

  void _loadingWeatherList(
      LoadingForecastEvent event, Emitter<CityState> emit) async {
    try {
      List<WeatherModel> weatherFavList =
          await _storageRepository.getFavWeatherList();
      emit(ForecastLoadedState(weatherFavList: weatherFavList));
    } catch (error) {
      emit(ForecastErrorState());
    }
  }

  void _goToLocations(GoToLocationsEvent event, Emitter<CityState> emit) async {
    emit(GoToLocationsState());
  }

  void _addCities(SearchCityEvent event, Emitter<CityState> emit) async {
    emit(LoadingCityState());

    if (_storageRepository.citiesFromJson.isEmpty) {
      await _storageRepository.getCitiesList();
    }
    if (_storageRepository.weatherFavList.isEmpty) {
      try {
        print(_storageRepository.citiesFromJson.length);
        final Cities cityAndCoord = _storageRepository.citiesFromJson
            .firstWhere(
                (e) => e.city.toLowerCase() == event.cityName.toLowerCase());

        await _storageRepository.addCity(cityAndCoord);
        _updateListCities();
      } catch (error) {
        print('City is not found');
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
          print('The city is already on the list.');
        }
      } catch (error) {
        print('City is not found.');
      }
    }
    emit(CityLoadedState());
  }

  void _updateCities(
      UpdateCitiesCardEvent event, Emitter<CityState> emit) async {
    emit(ForecastLoadedState(weatherFavList: event.weatherFavList));
  }

  void _updateListCities() async {
    List<WeatherModel> weatherFavList =
        await _storageRepository.getFavWeatherList();
    add(UpdateCitiesCardEvent(weatherFavList: weatherFavList));
  }

  void _deleteCities(DeleteCityEvent event, Emitter<CityState> emit) async {
    await _storageRepository.deleteCity(event.cityName);
    _updateListCities();
  }
}
