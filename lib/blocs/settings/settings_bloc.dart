import 'dart:async';
import 'package:bloc/bloc.dart';
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
      yield state;
    }
  }
}
