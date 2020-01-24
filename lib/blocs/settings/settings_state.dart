import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class SettingsState extends Equatable {
  final bool cnfActive;
  final bool localActive;

  SettingsState({@required this.cnfActive, @required this.localActive});
  SettingsState.initial()
    : this.cnfActive = true,
      this.localActive = true;

  SettingsState.clone(SettingsState settings,
      {bool cnfActive, bool localActive})
      : this(
          cnfActive: cnfActive ?? settings.cnfActive,
          localActive: localActive ?? settings.localActive,
        );

  @override List<Object> get props => [cnfActive, localActive];
}
