import 'package:flutter/material.dart';
import 'package:weather_app/widgets/reusable_column.dart';

class CitySearch extends StatelessWidget {
  const CitySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
          backgroundColor: Colors.deepPurple[300],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            return Center(
              child: Container(
                  height: 500,
                  width: 600,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: const Center(child: ReusableColumn())),
            );
          } else {
            return Container(
                color: Colors.deepPurple[100],
                padding: const EdgeInsets.all(30),
                child: const ReusableColumn());
          }
        }));
  }
}
