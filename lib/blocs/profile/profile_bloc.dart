import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chubster/models/units.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  @override
  ProfileState get initialState => ProfileState(
    height: Meters(1.751),
    metrics: [],
  );

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
