import 'package:chubster/models/food_source.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class LoadSettingsFromRepository extends SettingsEvent {
  @override List<Object> get props => [];
}

class SetFoodsSourceEvent extends SettingsEvent {
  final FoodSource source;
  final bool active;
  SetFoodsSourceEvent(this.source, this.active);

  @override List<Object> get props => [source, active];
}

class ToggleFoodsSourceEvent extends SettingsEvent {
  final FoodSource source;
  ToggleFoodsSourceEvent(this.source);

  @override List<Object> get props => [source];
}

