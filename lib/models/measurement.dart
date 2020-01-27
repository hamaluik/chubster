import 'package:chubster/models/units.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Measurement extends Equatable {
  final String measurement;
  final DateTime timestamp;
  final LengthUnits length;

  Measurement({@required this.measurement, this.timestamp, this.length})
      : assert(measurement != null),
        assert(length != null);

  @override
  List<Object> get props => [measurement, timestamp, length];
}
