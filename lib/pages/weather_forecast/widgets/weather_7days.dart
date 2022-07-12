import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Weather7days extends StatelessWidget {
  const Weather7days({Key? key, required this.page}) : super(key: key);
  final int page;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _bloc = context.read<WeaterBloc>();
    return Container(
      padding: EdgeInsets.zero,
      height: MediaQuery.of(context).size.height / 2.8,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text("Forcats for 7 Days",
                style: theme.textTheme.headline2, textAlign: TextAlign.center),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              padding: const EdgeInsets.only(bottom: 10),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: _bloc.state.weatherFavList[page].daily.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Text(
                            _bloc.state.weatherFavList[page].daily[index].dt,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.headline2),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: SvgPicture.asset(
                          "assets/icons/conditions/${_bloc.state.weatherFavList[page].daily[index].icon}.svg",
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                            "${(_bloc.state.weatherFavList[page].daily[index].pop * 100).toStringAsFixed(0)}% rain",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headline2),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                            "${_bloc.state.weatherFavList[page].daily[index].tempMin}°/${_bloc.state.weatherFavList[page].daily[index].tempMax}°",
                            textAlign: TextAlign.right,
                            style: theme.textTheme.headline2),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
