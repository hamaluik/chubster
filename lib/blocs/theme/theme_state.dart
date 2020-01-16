import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final Brightness brightness;
  final ThemeData theme;

  const ThemeState({@required this.brightness, @required this.theme}) : assert(theme != null);

  @override
  List<Object> get props => [brightness];
}
