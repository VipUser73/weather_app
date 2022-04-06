import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CityList {
  List<CityName> array;
  CityList({required this.array});

  factory CityList.fromJson(List<dynamic> cityJson) {
    List<CityName> cityList =
        cityJson.map((i) => CityName.fromJson(i)).toList();

    return CityList(array: cityList);
  }
}

class CityName {
  final String name;
  CityName({required this.name});

  factory CityName.fromJson(Map<String, dynamic> json) {
    return CityName(name: json['name'] as String);
  }
}

Future<CityList> getCityList() async {
  final String response = await rootBundle.loadString('assets/city_list.json');
  return CityList.fromJson(json.decode(response));
  //final data = await json.decode(response);
}

class CityListView extends StatelessWidget {
  final AsyncSnapshot<CityList> snapshot;
  const CityListView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${snapshot.data?.array[1].name}",
      style: const TextStyle(color: Colors.white),
    );

    // ListView(
    //   padding: const EdgeInsets.symmetric(horizontal: 10),
    //   shrinkWrap: true,
    //   children: items.map((e) => LocationVH(item: e)).toList(),
    // );

    // return ListView.separated(
    //   separatorBuilder: (context, index) => const SizedBox(width: 8),
    //   itemCount: snapshot.data!.list!.length,
    //   itemBuilder: (context, index) => LocationVH(item: items[index]),
    // );
  }
}
