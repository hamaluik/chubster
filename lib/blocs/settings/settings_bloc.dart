import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chubster/models/food_source.dart';
import 'package:chubster/repositories/settings_repository.dart';
import './bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settings;
  SettingsBloc(this.settings);

  @override
  SettingsState get initialState => SettingsState.initial();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if(event is LoadSettingsFromRepository) {
      bool localActive = settings.prefs.getBool("localActive") ?? state.localActive;
      bool cnfActive = settings.prefs.getBool("cnfActive") ?? state.cnfActive;
      yield SettingsState(localActive: localActive, cnfActive: cnfActive);
    }
    else if(event is SetFoodsSourceEvent) {
      switch(event.source) {
        case FoodSource.local:
          await settings.prefs.setBool("localActive", event.active);
          yield SettingsState.clone(state, localActive: event.active);
          break;
        case FoodSource.cnf:
          await settings.prefs.setBool("cnfActive", event.active);
          yield SettingsState.clone(state, cnfActive: event.active);
          break;
      }
    }
    else if(event is ToggleFoodsSourceEvent) {
      switch(event.source) {
        case FoodSource.local:
          await settings.prefs.setBool("localActive", !state.localActive);
          yield SettingsState.clone(state, localActive: !state.localActive);
          break;
        case FoodSource.cnf:
          await settings.prefs.setBool("cnfActive", !state.cnfActive);
          yield SettingsState.clone(state, cnfActive: !state.cnfActive);
          break;
      }
    }
  }
}
