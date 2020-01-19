import 'package:chubster/blocs/profile/bloc.dart';
import 'package:chubster/models/sex.dart';
import 'package:chubster/models/units.dart';
import 'package:chubster/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

class ProfileState extends Equatable {
  final Sex sex;
  final LengthUnits height;
  final WeightUnits weight;
  ProfileState({this.sex, this.height, this.weight});

  double get bmi {
    if (this.weight == null) return null;
    if (this.height == null) return null;
    if (this.height.value <= double.minPositive) return null;
    return this.weight.toKiloGrams().value / pow(height.toMeters().value, 2);
  }

  static Future<ProfileState> initial(ProfileRepository repository) async {
    Sex sex = repository.getSex();
    LengthUnits height = repository.getHeight();
    WeightUnits weight = await repository.getCurrentWeight();
    return ProfileState(sex: sex, height: height, weight: weight);
  }

  ProfileState.clone(ProfileState profile,
      {Sex sex, LengthUnits height, WeightUnits weight})
      : this(
          sex: sex ?? profile.sex,
          height: height ?? profile.height,
          weight: weight ?? profile.weight,
        );

  @override
  List<Object> get props => [sex, height, weight];
}
