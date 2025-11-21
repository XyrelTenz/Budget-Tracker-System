import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _seedColor = Color(0xFF0046FF);

final TextTheme _appTextTheme = TextTheme(
  displayLarge: GoogleFonts.montserrat(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    letterSpacing: -1.5,
  ),

  titleLarge: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w600),

  bodyMedium: GoogleFonts.openSans(fontSize: 16, height: 1.5),

  displaySmall: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w500),
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
