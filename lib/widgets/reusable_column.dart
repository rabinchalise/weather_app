import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../page/weather.dart';
import '../provider/city_provider.dart';

class ReusableColumn extends StatelessWidget {
  const ReusableColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cityName = Provider.of<CityProvider>(context, listen: false).cityName;
    return Column(
      children: [
        Icon(
          Icons.location_city,
          color: Colors.grey.shade300,
          size: 100,
        ),
        const SizedBox(height: 20),
        TextField(
            controller: cityName,
            onChanged: (value) {
              cityName.text = value;
            },
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for a city..',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none))),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Weather(
                            cityName: cityName.text,
                          )));
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.deepPurple[200]),
            child: const Text(
              'Get Weather',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
