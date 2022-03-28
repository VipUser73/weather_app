import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField(this.currentCityName, this.setNewCityName, {Key? key})
      : super(key: key);
  final void Function(String cityName) setNewCityName;
  final String currentCityName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search for a city or airport',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              icon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            onSubmitted: setNewCityName,
          ),
        ),
      ],
    );
  }
}
