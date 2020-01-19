import 'package:chubster/models/units.dart';
import 'package:flutter/foundation.dart';

class Metric {
  final String name;
  final Units units;
  final double value;

  Metric({@required this.name, @required this.units, @required this.value});
}