import 'package:chubster/models/metric.dart';
import 'package:chubster/models/units.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ProfileState extends Equatable {
  final Meters height;
  final List<Metric> metrics;
  ProfileState({@required this.height, @required this.metrics});

  @override List<Object> get props => [];
}
