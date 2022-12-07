import 'package:flutter/material.dart';

class Config {
  static final ThemeData myTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(color: Colors.black),
      buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF8875FF), textTheme: ButtonTextTheme.normal),
      textTheme: ThemeData.dark().textTheme.copyWith(
            titleLarge: const TextStyle(
                fontFamily: 'lato', fontWeight: FontWeight.w700, fontSize: 48),
            titleMedium: const TextStyle(
                fontFamily: 'lato', fontWeight: FontWeight.w700, fontSize: 40),
            titleSmall: const TextStyle(
                fontFamily: 'lato', fontWeight: FontWeight.w700, fontSize: 32),
            bodyLarge: const TextStyle(
                fontFamily: 'lato', fontWeight: FontWeight.w500, fontSize: 32),
            bodyMedium: const TextStyle(
                fontFamily: 'lato', fontWeight: FontWeight.w500, fontSize: 24),
            bodySmall: const TextStyle(
                fontFamily: 'lato', fontWeight: FontWeight.w300, fontSize: 16),
          ));
}
