import 'package:chubster/models/units.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class WeightMeasurement extends Equatable {
  final DateTime timestamp;
  final WeightUnits weight;

  WeightMeasurement({this.timestamp, @required this.weight})
      : assert(weight != null);

  @override
  List<Object> get props => [timestamp, weight];
}
