import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/weather_event.dart';
import 'package:flutter_app/bloc/weather_state.dart';
import 'package:flutter_app/bloc/weather_bloc.dart';
import 'package:flutter_app/pages/manage_location/widgets/city_card.dart';
import 'package:flutter_app/pages/manage_location/widgets/search_city.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.headline2;
    return Scaffold(
        body: BlocListener<WeaterBloc, WeatherState>(
      listener: (context, state) {
        if (state is CityNotFoundState) {
          SnackBar snackBar = SnackBar(
            backgroundColor: Colors.red.shade400,
            content: const Text(
              'City is not found!',
              textAlign: TextAlign.center,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<WeaterBloc>().add(LoadingForecastEvent());
        }
        if (state is CityAlreadyOnListState) {
          SnackBar snackBar = SnackBar(
            backgroundColor: Colors.red.shade400,
            content: const Text(
              'The city is already on the list!',
              textAlign: TextAlign.center,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<WeaterBloc>().add(LoadingForecastEvent());
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(98, 184, 246, 1),
              Color.fromRGBO(44, 121, 193, 1)
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("Manage location", style: titleTextStyle),
                const SearchCity(),
                const CityCard(),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
