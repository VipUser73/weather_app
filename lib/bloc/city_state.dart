abstract class CityState {}

class CityEmptyState extends CityState {}

class CityLoadingState extends CityState {}

class CityLoadedState extends CityState {
  List<dynamic> LoadedCity;
  CityLoadedState({required this.LoadedCity});
}

class CityErrorState extends CityState {}
