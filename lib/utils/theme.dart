import 'package:flutter/material.dart';

var kLightColorScheme =
    ColorScheme.fromSeed(seedColor: const Color(0xFFF3F3F3));
var kDarkColorScheme = ColorScheme.fromSeed(seedColor: const Color(0x001d1b1f));

ThemeData lightTheme() => ThemeData().copyWith(
      colorScheme: kLightColorScheme,
    );

ThemeData darkTheme() => ThemeData.dark().copyWith(
      colorScheme: kDarkColorScheme,
    );
