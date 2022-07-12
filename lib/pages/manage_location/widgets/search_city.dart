import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/weather_bloc.dart';
import 'package:flutter_app/bloc/weather_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCity extends StatelessWidget {
  const SearchCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5),
          hintText: 'Search for a city or airport',
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        onSubmitted: (text) =>
            context.read<WeaterBloc>().add(SearchCityEvent(text)),
      ),
    );
  }
}
