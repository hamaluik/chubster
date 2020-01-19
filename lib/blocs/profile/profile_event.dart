import 'package:chubster/models/sex.dart';
import 'package:chubster/models/units.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfileFromRepository extends ProfileEvent {
  @override List<Object> get props => [];
}

class ChangeSex extends ProfileEvent {
  final Sex newSex;
  ChangeSex(this.newSex);

  @override List<Object> get props => [newSex];
}

class SetHeight extends ProfileEvent {
  final LengthUnits newHeight;
  SetHeight(this.newHeight);

  @override List<Object> get props => [newHeight];
}
