import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chubster/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(
        brightness: WidgetsBinding.instance.window.platformBrightness,
        theme: WidgetsBinding.instance.window.platformBrightness ==
                Brightness.light
            ? lightTheme
            : darkTheme,
      );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is BrightnessChanged) {
      switch (event.brightness) {
        case Brightness.dark:
          {
            yield new ThemeState(brightness: Brightness.dark, theme: darkTheme);
            break;
          }
        case Brightness.light:
          {
            yield new ThemeState(
                brightness: Brightness.light, theme: lightTheme);
            break;
          }
      }
    }
  }
}
