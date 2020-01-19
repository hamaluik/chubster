import 'package:chubster/models/units.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class LoadSettingsFromRepository extends SettingsEvent {
  @override List<Object> get props => [];
}
