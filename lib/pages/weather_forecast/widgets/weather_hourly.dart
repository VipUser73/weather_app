import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherHourly extends StatelessWidget {
  const WeatherHourly({Key? key, required this.page}) : super(key: key);
  final int page;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _bloc = context.read<WeaterBloc>();
    return Container(
      height: 110,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _bloc.state.weatherFavList[page].hourly.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (index == 0) ...[
                  Text("Now", style: theme.textTheme.headline1),
                ] else ...[
                  Text(
                      _bloc.state.weatherFavList[page].hourly[index].hour
                          .toString(),
                      style: theme.textTheme.headline1)
                ],
                SvgPicture.asset(
                  ("assets/icons/conditions/${_bloc.state.weatherFavList[page].hourly[index].icon}.svg"),
                  width: 30,
                  height: 30,
                ),
                Text("${_bloc.state.weatherFavList[page].hourly[index].temp}°",
                    style: theme.textTheme.headline1),
                Text(
                    "${(_bloc.state.weatherFavList[page].hourly[index].pop * 100).toStringAsFixed(0)}% rain",
                    style: theme.textTheme.headline1),
              ],
            ),
          );
        },
      ),
    );
  }
}
