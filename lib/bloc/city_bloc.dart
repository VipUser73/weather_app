import 'package:flutter_bloc/flutter_bloc.dart';
import 'city_event.dart';
import 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc(initialState) : super(initialState);
}
