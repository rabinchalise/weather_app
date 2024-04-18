import 'package:flutter/material.dart';

class CityProvider extends ChangeNotifier {
  final TextEditingController _cityName = TextEditingController();

  TextEditingController get cityName => _cityName;

  void getCityName(String cityName) {
    cityName = _cityName.text;
    notifyListeners();
  }
}
