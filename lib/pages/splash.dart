// import 'package:flutter/material.dart';
// import 'package:flutter_app/bloc/app_bloc.dart';
// import 'package:flutter_app/pages/weather_forecast/forecast_page.dart';
// import 'package:flutter_app/repositories/local_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppBloc, AppState>(
//         bloc: AppBloc(context.read<LocalRepository>()),
//         listener: (context, state) {
//           goToLocations(context);
//         },
//         buildWhen: (state1, state2) => false,
//         builder: (context, state) => Scaffold(
//               body: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Color.fromRGBO(98, 184, 246, 1),
//                       Color.fromRGBO(44, 121, 193, 1)
//                     ],
//                   ),
//                 ),
//                 child: const Center(
//                     child: CircularProgressIndicator(color: Colors.white)),
//               ),
//             ));
//   }

//   void goToLocations(BuildContext context) async {
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (BuildContext context) => ForecastPage()));
//   }
// }
