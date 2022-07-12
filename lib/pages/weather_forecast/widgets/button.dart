import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/weather_bloc.dart';
import 'package:flutter_app/bloc/weather_event.dart';
import 'package:flutter_app/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonForecast extends StatelessWidget {
  const ButtonForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeaterBloc, WeatherState>(
        listener: (context, state) {
          if (state is GoToLocationsState) {
            Navigator.of(context).pushNamed('/locations');
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 5, right: 5),
          child: TextButton(
            onPressed: () {
              context.read<WeaterBloc>().add(GoToLocationsEvent());
            },
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.white,
            ),
          ),
        ));
  }
}
