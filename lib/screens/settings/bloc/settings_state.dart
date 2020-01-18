import 'package:equatable/equatable.dart';

enum BodyWeightUnits { lbs, kgs, stone }
enum EnergyUnits { KCal, KJ }

class SettingsState extends Equatable {
  final BodyWeightUnits bodyWeightUnits;
  final EnergyUnits energyUnits;
  SettingsState({this.bodyWeightUnits = BodyWeightUnits.lbs, this.energyUnits = EnergyUnits.KCal});

  SettingsState.clone(SettingsState settings, {BodyWeightUnits bodyWeightUnits, EnergyUnits energyUnits})
  : this(bodyWeightUnits: bodyWeightUnits ?? settings.bodyWeightUnits, energyUnits: energyUnits ?? settings.energyUnits);

  @override
  List<Object> get props => [bodyWeightUnits];
}
