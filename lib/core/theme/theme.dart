import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _seedColor = Color(0xFF0046FF);

final TextTheme _appTextTheme = TextTheme(
  displayLarge: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
  titleLarge: GoogleFonts.oswald(fontSize: 30, fontStyle: FontStyle.italic),
  bodyMedium: GoogleFonts.roboto(),
  displaySmall: GoogleFonts.roboto(),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.light,
  ),
  textTheme: _appTextTheme,
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
  ),
  textTheme: _appTextTheme,
);
