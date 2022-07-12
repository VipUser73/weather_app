import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/weather_bloc.dart';
import 'package:flutter_app/bloc/weather_event.dart';
import 'package:flutter_app/bloc/weather_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_app/pages/weather_forecast/widgets/weather_7days.dart';
import 'package:flutter_app/pages/weather_forecast/widgets/weather_hourly.dart';
import 'package:flutter_app/pages/weather_forecast/widgets/weathet_now.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class PageViewWidget extends StatelessWidget {
  PageViewWidget({Key? key}) : super(key: key);
  var _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeaterBloc, WeatherState>(
        bloc: context.read<WeaterBloc>()..add(LoadingForecastEvent()),
        builder: (context, state) {
          final theme = Theme.of(context);
          final titleTextStyle = theme.textTheme.headline1;
          if (state.indexPage != 0) {
            _controller = PageController(initialPage: state.indexPage);
          }
          if (state is LoadingForecastState) {
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
                      "The list of cities is empty!\nTo add, click on the icon at the top.",
                      style: titleTextStyle?.copyWith(fontSize: 20),
                    ),
                  )
                : Expanded(
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: _controller,
                            itemCount: state.weatherFavList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    return context
                                        .read<WeaterBloc>()
                                        .add(LoadingForecastEvent());
                                  },
                                  child: ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(
                                            parent: BouncingScrollPhysics()),
                                    children: [
                                      WeatherNow(page: index),
                                      WeatherHourly(page: index),
                                      Weather7days(page: index),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SmoothPageIndicator(
                                  controller: _controller,
                                  count: state.weatherFavList.length,
                                  effect: ScrollingDotsEffect(
                                    dotColor: Colors.blue.shade400,
                                    activeDotColor: Colors.white,
                                    dotWidth: 10,
                                    dotHeight: 6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
        });
  }
}
