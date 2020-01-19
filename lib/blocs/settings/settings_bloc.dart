import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chubster/models/units.dart';
import 'package:chubster/repositories/settings_repository.dart';
import './bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settings;
  SettingsBloc(this.settings);

  @override
  SettingsState get initialState => SettingsState();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if(event is LoadSettingsFromRepository) {
      String bodyWeightUnitsStr = settings.prefs.getString("bodyWeightUnits");
      BodyWeightUnits bodyWeightUnits = state.bodyWeightUnits;
      if(bodyWeightUnitsStr != null) {
        bodyWeightUnits = BodyWeightUnits.values.firstWhere((e) => e.toString() == bodyWeightUnitsStr);
      }

      String energyUnitsStr = settings.prefs.getString("energyUnits");
      EnergyUnits energyUnits = state.energyUnits;
      if(energyUnitsStr != null) {
        energyUnits = EnergyUnits.values.firstWhere((e) => e.toString() == energyUnitsStr);
      }

      final SettingsState s = SettingsState(
        bodyWeightUnits: bodyWeightUnits,
        energyUnits: energyUnits,
      );
      print('loaded settings: ' + s.toString());
      yield s;
    }
    else if(event is ChangeWeightUnits) {
      await settings.prefs.setString("bodyWeightUnits", event.newUnits.toString());
      yield SettingsState.clone(state, bodyWeightUnits: event.newUnits);
    }
    else if(event is ChangeEnergyUnits) {
      await settings.prefs.setString("energyUnits", event.newUnits.toString());
      yield SettingsState.clone(state, energyUnits: event.newUnits);
    }
  }
}
