import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      textTheme: textTheme,
      colorScheme: const ColorScheme.light(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      textTheme: textTheme,
      colorScheme: const ColorScheme.dark(),
    );
  }
}

enum AppTheme {light, dark}

const textTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.normal,
    fontSize: 57,
    height: 1.1,
    letterSpacing: -0.25,
  ),
  displayMedium: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.normal,
    fontSize: 45,
    height: 1.14,
  ),
  displaySmall: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.normal,
    fontSize: 36,
    height: 1.2,
  ),
  headlineLarge: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.normal,
    fontSize: 32,
    height: 1.25,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.normal,
    fontSize: 28,
    height: 1.28,
  ),
  headlineSmall: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.normal,
    fontSize: 24,
    height: 1.3,
  ),
  titleLarge: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.w400,
    fontSize: 22,
    height: 1.27,
  ),
  titleMedium: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.15,
  ),
  titleSmall: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.1,
  ),
  labelLarge: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.1,
  ),
  labelMedium: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.2,
    letterSpacing: 0.5,
  ),
  labelSmall: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.w500,
    fontSize: 11,
    height: 1.45,
    letterSpacing: 0.5,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.5,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.25,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Halvar',
    fontWeight: FontWeight.normal,
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
  ),
);
