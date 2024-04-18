import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  const AdditionalInfoItem({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.data,
  });
  final String imgUrl;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imgUrl,
          height: 50,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(data,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))
      ],
    );
  }
}
