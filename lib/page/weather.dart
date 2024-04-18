import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:weather_app/widgets/additional_information.dart';
import 'package:weather_app/widgets/hourly_forecast_card.dart';

class Weather extends StatefulWidget {
  const Weather({super.key, required this.cityName});

  final String cityName;
  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=${widget.cityName}&APPID=${dotenv.env['APIKEY']}&units=metric'));

      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw 'An unexpected error occured';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    weather = getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final data = snapshot.data!;

            final currentWeatherData = data['list'][0];
            final currentTemp = currentWeatherData['main']['temp_max'];
            final currentSky = currentWeatherData['weather'][0]['main'];
            final currentPressure = currentWeatherData['main']['pressure'];
            final currentWindSpeed = currentWeatherData['wind']['speed'];
            final currentHumidity = currentWeatherData['main']['humidity'];
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: currentSky == 'Clouds'
                          ? const AssetImage(
                              'assets/images/cloud.webp',
                            )
                          : currentSky == 'Rain'
                              ? const AssetImage(
                                  'assets/images/rainy.jpeg',
                                )
                              : const AssetImage(
                                  'assets/images/sun.webp',
                                ))),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back,
                                  size: 30, color: Colors.white),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              widget.cityName,
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(40)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: <Widget>[
                                      currentSky == 'Clouds'
                                          ? Image.asset('assets/icons/vain.png')
                                          : currentSky == 'Rain'
                                              ? Image.asset(
                                                  'assets/icons/weather.png')
                                              : Image.asset(
                                                  'assets/icons/smiling.png'),
                                      Text(
                                        '$currentTemp°',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 70,
                                            color: Colors.white),
                                      ),
                                      Text(currentSky.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Hourly Forecast',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 140,
                          child: ListView.builder(
                              itemCount: 8,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                final hourlyForecast = data['list'][index + 1];
                                final hourlyTime = hourlyForecast['dt_txt'];
                                final hourlyTemp =
                                    hourlyForecast['main']['temp_max'];
                                final skyConditions =
                                    hourlyForecast['weather'][0]['main'];
                                final time = DateTime.parse(hourlyTime);
                                return HourlyForecastCard(
                                    time: DateFormat.j().format(time),
                                    icon: skyConditions == 'Clouds'
                                        ? 'assets/icons/vain.png'
                                        : skyConditions == 'Rain'
                                            ? 'assets/icons/weather.png'
                                            : 'assets/icons/smiling.png',
                                    temperature: '$hourlyTemp°');
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Additional Information',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    AdditionalInfoItem(
                                        imgUrl: 'assets/icons/weather-2.png',
                                        title: 'Wind',
                                        data: '$currentWindSpeed m/s'),
                                    AdditionalInfoItem(
                                        imgUrl: 'assets/icons/drop.png',
                                        title: 'Humidity',
                                        data: '$currentHumidity %'),
                                    AdditionalInfoItem(
                                        imgUrl: 'assets/icons/pressure.png',
                                        title: 'Pressure',
                                        data: '$currentPressure'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
