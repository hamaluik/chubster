import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class BrightnessChanged extends ThemeEvent {
  final Brightness brightness;

  const BrightnessChanged({@required this.brightness}) : assert(brightness != null);

  @override
  List<Object> get props => [brightness];
}
