import 'package:flutter_app/repositories/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppEvent {}

class InitialisedEvent extends AppEvent {}

abstract class AppState {}

class LoadingRepositoryState extends AppState {}

class LoadedRepositoryState extends AppState {}

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._storageRepository) : super(LoadingRepositoryState()) {
    on<InitialisedEvent>(_loadedRepository);
    _loadingRepository();
  }
  final LocalRepository _storageRepository;

  Future<void> _loadedRepository(InitialisedEvent e, Emitter emit) async {
    emit(LoadedRepositoryState());
  }

  Future<void> _loadingRepository() async {
    await _storageRepository.getFavWeatherList();
    add(InitialisedEvent());
  }
}
