import "package:riverpod/riverpod.dart";
import 'package:flutter/material.dart';
import './theme.dart';

class ThemeController extends Notifier<ThemeData> {
  @override
  ThemeData build() {
    return lightTheme;
  }

  void setLight() => state = lightTheme;
  void setDark() => state = darkTheme;

  void setCustom(ThemeData custom) => state = custom;
}

final themeProvider = NotifierProvider<ThemeController, ThemeData>(
  ThemeController.new,
);
