import 'package:chubster/models/units.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class ChangeWeightUnits extends SettingsEvent {
  final BodyWeightUnits newUnits;
  ChangeWeightUnits(this.newUnits);

  @override List<Object> get props => [newUnits];
}

class ChangeEnergyUnits extends SettingsEvent {
  final EnergyUnits newUnits;
  ChangeEnergyUnits(this.newUnits);

  @override List<Object> get props => [newUnits];
}