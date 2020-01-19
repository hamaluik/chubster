import 'package:chubster/models/sex.dart';
import 'package:chubster/models/units.dart';
import 'package:chubster/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'dart:math';

class ProfileState extends Equatable {
  final Sex sex;
  final LengthUnits height;
  final WeightUnits weight;
  final DateTime birthday;
  ProfileState(
      {this.sex, this.height, this.weight, this.birthday});

  double get bmi {
    if (this.weight == null) return null;
    if (this.height == null) return null;
    if (this.height.value <= double.minPositive) return null;
    return this.weight.toKiloGrams().value / pow(height.toMeters().value, 2);
  }

  int get age {
    return (DateTime.now()
                .difference(birthday)
                .inDays
                .toDouble() /
            365.25)
        .floor();
  }

  double get bodyFatPercent {
    double b = bmi;
    if(b == null) return null;
    if(birthday == null) return null;
    if(sex == null) return null;

    double bf = (1.39 * b) + (0.16 * age.toDouble()) - (9);
    if(sex == Sex.male) bf -= 10.34;
    return bf;
  }

  static Future<ProfileState> initial(ProfileRepository repository) async {
    Sex sex = repository.getSex();
    LengthUnits height = repository.getHeight();
    WeightUnits weight = await repository.getCurrentWeight();
    DateTime birthday = repository.getBirthday();
    return ProfileState(sex: sex, height: height, weight: weight, birthday: birthday);
  }

  ProfileState.clone(ProfileState profile,
      {Sex sex, LengthUnits height, WeightUnits weight, DateTime birthday})
      : this(
          sex: sex ?? profile.sex,
          height: height ?? profile.height,
          weight: weight ?? profile.weight,
          birthday: birthday ?? profile.birthday,
        );

  @override
  List<Object> get props => [sex, height, weight, birthday];
}
