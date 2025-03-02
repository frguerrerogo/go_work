import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.amber,
  Colors.amberAccent,
  Colors.blue,
  Colors.blueAccent,
  Colors.blueGrey,
  Colors.brown,
  Colors.cyan,
  Colors.cyanAccent,
  Colors.deepOrange,
  Colors.deepOrangeAccent,
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.green,
  Colors.greenAccent,
  Colors.grey,
  Colors.indigo,
  Colors.indigoAccent,
  Colors.lightBlue,
  Colors.lightBlueAccent,
  Colors.lightGreen,
  Colors.lightGreenAccent,
  Colors.lime,
  Colors.limeAccent,
  Colors.orange,
  Colors.orangeAccent,
  Colors.pink,
  Colors.pinkAccent,
  Colors.purple,
  Colors.purpleAccent,
  Colors.red,
  Colors.redAccent,
  Colors.teal,
  Colors.tealAccent,
  Colors.yellow,
  Colors.yellowAccent,
];

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
