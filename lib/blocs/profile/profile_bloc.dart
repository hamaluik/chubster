import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chubster/repositories/profile_repository.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profile;
  ProfileBloc(this._profile);

  @override
  ProfileState get initialState => ProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if(event is LoadProfileFromRepository) {
      yield await ProfileState.initial(_profile);
    }
    else if(event is ChangeSex) {
      Debounce.milliseconds(500, () => _profile.setSex(event.newSex));
      yield ProfileState.clone(state, sex: event.newSex);
    }
    else if(event is SetHeight) {
      Debounce.milliseconds(500, () => _profile.setHeight(event.newHeight));
      yield ProfileState.clone(state, height: event.newHeight);
    }
  }
}
