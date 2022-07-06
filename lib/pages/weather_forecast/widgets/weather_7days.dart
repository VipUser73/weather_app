import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/city_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Weather7days extends StatelessWidget {
  const Weather7days({Key? key, required this.page}) : super(key: key);
  final int page;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CityBloc, CityState>(
        bloc: context.read<CityBloc>(),
        builder: (context, state) {
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
                      style: theme.textTheme.headline1,
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.weatherFavList[page].daily.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Text(
                                  state.weatherFavList[page].daily[index].dt,
                                  textAlign: TextAlign.left,
                                  style: theme.textTheme.headline1),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                "assets/icons/conditions/${state.weatherFavList[page].daily[index].icon}.svg",
                                alignment: Alignment.center,
                                width: 35,
                                height: 35,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                                "${(state.weatherFavList[page].daily[index].pop * 100).toStringAsFixed(0)}% rain",
                                textAlign: TextAlign.left,
                                style: theme.textTheme.headline1),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                  "${state.weatherFavList[page].daily[index].tempMin}°/${state.weatherFavList[page].daily[index].tempMax}°",
                                  textAlign: TextAlign.left,
                                  style: theme.textTheme.headline1),
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
        });
  }
}
