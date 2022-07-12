import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/weather_bloc.dart';
import 'package:flutter_app/models/theme.dart';
import 'package:flutter_app/pages/manage_location/locations_page.dart';
import 'package:flutter_app/pages/weather_forecast/forecast_page.dart';
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
        child: BlocProvider<WeaterBloc>(
          create: (context) => WeaterBloc(context.read<LocalRepository>()),
          child: MaterialApp(
            routes: {
              '/': (context) => const ForecastPage(),
              '/locations': (context) => const LocationsPage()
            },
            initialRoute: '/',
            theme: themeData,
          ),
        ));
  }
}
