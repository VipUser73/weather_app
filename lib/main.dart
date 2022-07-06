import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/city_bloc.dart';
import 'package:flutter_app/models/theme.dart';
import 'package:flutter_app/pages/splash.dart';
import 'package:flutter_app/services/db_provider.dart';
import 'package:flutter_app/repositories/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final LocalRepository _storageRepository = LocalRepository(DBProvider());
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _storageRepository,
        child: BlocProvider<CityBloc>(
          create: (context) => CityBloc(context.read<LocalRepository>()),
          child: MaterialApp(
            theme: themeData,
            home: const SplashScreen(),
          ),
        ));
  }
}
