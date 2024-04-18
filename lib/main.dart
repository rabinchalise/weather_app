import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/page/city_search.dart';

import 'package:weather_app/provider/city_provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(ChangeNotifierProvider(
      create: (context) => CityProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: CitySearch());
  }
}
