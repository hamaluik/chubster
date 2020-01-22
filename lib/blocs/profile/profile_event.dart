import 'package:chubster/models/sex.dart';
import 'package:chubster/models/units.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfileFromRepository extends ProfileEvent {
  @override List<Object> get props => [];
}

class SetBirthday extends ProfileEvent {
  final DateTime newBirthday;
  SetBirthday(this.newBirthday);

  @override List<Object> get props => [newBirthday];
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

/// Update the in-memory weight, but don't persist it to disk. Emit `RecordWeight` _after_ SetWeight to save the weight
class SetWeight extends ProfileEvent {
  final WeightUnits newWeight;
  SetWeight(this.newWeight);

  @override List<Object> get props => [newWeight];
}


/// Save the current weight to the database, effectively manually debouncing `SetWeight`
class RecordWeight extends ProfileEvent {
  @override List<Object> get props => [];
}
