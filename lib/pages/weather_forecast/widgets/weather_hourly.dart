import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/city_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/models/weather_model.dart';

class WeatherHourly extends StatelessWidget {
  const WeatherHourly({Key? key, required this.page}) : super(key: key);
  final int page;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CityBloc, CityState>(
        bloc: context.read<CityBloc>(),
        builder: (context, state) {
          return Container(
            height: 110,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.weatherFavList[page].hourly.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width / 4.6,
                  height: 150,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (index == 0) ...[
                        Text("Now", style: theme.textTheme.headline1),
                      ] else ...[
                        Text(
                            state.weatherFavList[page].hourly[index].hour
                                .toString(),
                            style: theme.textTheme.headline1)
                      ],
                      SvgPicture.asset(
                        ("assets/icons/conditions/${state.weatherFavList[page].hourly[index].icon}.svg"),
                        width: 30,
                        height: 30,
                      ),
                      Text("${state.weatherFavList[page].hourly[index].temp}°",
                          style: theme.textTheme.headline1),
                      Text(
                          "${(state.weatherFavList[page].hourly[index].pop * 100).toStringAsFixed(0)}% rain",
                          style: theme.textTheme.headline1),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
