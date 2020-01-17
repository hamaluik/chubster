import 'package:flutter/material.dart';

final ThemeData lightTheme = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  primaryColor: Colors.green[500],
  primaryColorBrightness: Brightness.dark,
  accentColor: Colors.green[500],
  accentColorBrightness: Brightness.dark,
  fontFamily: 'PublicSans',
);

final ThemeData darkTheme = new ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey[900],
  primaryColorBrightness: Brightness.dark,
  accentColor: Colors.green[500],
  accentColorBrightness: Brightness.light,
  fontFamily: 'PublicSans',
);
