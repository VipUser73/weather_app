import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/weather_bloc.dart';
import 'package:flutter_app/bloc/weather_event.dart';
import 'package:flutter_app/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CityCard extends StatelessWidget {
  const CityCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.headline1;

    return BlocConsumer<WeaterBloc, WeatherState>(
        bloc: context.read<WeaterBloc>()..add(LoadingForecastEvent()),
        listener: (context, state) {
          if (state is GoToInitialPageState) {
            Navigator.of(context).pushNamed('/');
          }
        },
        builder: (context, state) {
          if (state is LoadingCityState) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
          if (state is ForecastErrorState) {
            return Center(
              child: Text(
                "Failed to load data.",
                style: titleTextStyle?.copyWith(fontSize: 20),
              ),
            );
          }

          if ((state is ForecastLoadedState)) {
            return state.weatherFavList.isEmpty
                ? Center(
                    child: Text(
                      "The list of cities is empty!",
                      style: titleTextStyle?.copyWith(fontSize: 20),
                    ),
                  )
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        return context
                            .read<WeaterBloc>()
                            .add(LoadingForecastEvent());
                      },
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount: state.weatherFavList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) => context
                                    .read<WeaterBloc>()
                                    .add(DeleteCityEvent(
                                        state.weatherFavList[index].name)),
                                background: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.centerRight,
                                  child: const Icon(Icons.delete,
                                      color: Colors.white),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<WeaterBloc>()
                                        .add(GoToInitialPageEvent(index));
                                  },
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color:
                                        const Color.fromARGB(255, 50, 100, 160),
                                    shadowColor: Colors.blueGrey,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    state.weatherFavList[index]
                                                        .name,
                                                    maxLines: 1,
                                                    style: theme
                                                        .textTheme.headline1),
                                                Text(
                                                  state.weatherFavList[index]
                                                      .description,
                                                  style: theme
                                                      .textTheme.headline1
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color:
                                                              Colors.white38),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  "assets/icons/conditions/${state.weatherFavList[index].icon}.svg",
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "${state.weatherFavList[index].temp}°C",
                                                style: theme.textTheme.headline1
                                                    ?.copyWith(fontSize: 30),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
        });
  }
}
