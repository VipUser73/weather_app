import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/city_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonForecast extends StatelessWidget {
  const ButtonForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CityBloc, CityState>(
        listener: (context, state) {
          if (state is GoToLocationsState) {
            Navigator.of(context).pushNamed('/locations');
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 5, right: 5),
          child: TextButton(
            onPressed: () {
              context.read<CityBloc>().add(GoToLocationsEvent());
              // Route route = MaterialPageRoute(
              //     builder: (context) => const LocationsPage());
              // Navigator.push(context, route);
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
