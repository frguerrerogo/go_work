import 'package:flutter/material.dart';

class AppTheme {
  final Color? selectedColor;
  final bool? isDarkmode;

  AppTheme({
    this.selectedColor = Colors.red,
    this.isDarkmode = false,
  });

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: selectedColor,
        brightness: isDarkmode! ? Brightness.dark : Brightness.light,
      );

  AppTheme copyWith({
    Color? selectedColor,
    bool? isDarkmode,
  }) =>
      AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkmode: isDarkmode ?? this.isDarkmode,
      );
}
