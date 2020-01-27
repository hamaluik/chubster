import 'package:chubster/models/activity_level.dart';
import 'package:chubster/models/sex.dart';
import 'package:chubster/models/units.dart';
import 'package:chubster/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'dart:math';

class ProfileState extends Equatable {
  final Sex sex;
  final ActivityLevel activityLevel;
  final LengthUnits height;
  final WeightUnits weight;
  final DateTime birthday;
  ProfileState(
      {this.sex, this.activityLevel, this.height, this.weight, this.birthday});

  double get bmi {
    if (this.weight == null) return null;
    if (this.height == null) return null;
    if (this.height.value <= double.minPositive) return null;
    return this.weight.toKiloGrams().value / pow(height.toMeters().value, 2);
  }

  /// The age of the person in years
  double get age {
    return DateTime.now().difference(birthday).inDays.toDouble() / 365.25;
  }

  /// The estimated body fat percent (0–100)
  ///
  /// https://en.wikipedia.org/wiki/Body_fat_percentage#From_BMI
  double get bodyFatPercent {
    double b = bmi;
    if (b == null) return null;
    if (birthday == null) return null;
    if (sex == null) return null;

    double bf = (1.39 * b) + (0.16 * age) - (9);
    if (sex == Sex.male) bf -= 10.34;
    return bf;
  }

  /// The resting daily energy expenditure in kCal / day
  ///
  /// From the Katch-McArdle formula:
  /// https://en.wikipedia.org/wiki/Basal_metabolic_rate#BMR_estimation_formulas
  double get restingDailyEnergy {
    double m = this.weight?.toKiloGrams()?.value;
    double f = this.bodyFatPercent;
    if (m == null || f == null) return null;
    double l = m * (1.0 - (f / 100.0));
    return 370.0 + (21.6 * l);
  }

  double get totalDailyEnergy {
    double r = this.restingDailyEnergy;
    if(this.restingDailyEnergy == null) return null;
    double m = this.activityLevel?.multiplier;
    if(m == null) return null;
    return r * m;
  }

  static Future<ProfileState> initial(ProfileRepository repository) async {
    Sex sex = repository.getSex();
    ActivityLevel activityLevel = repository.getActivityLevel();
    LengthUnits height = repository.getHeight();
    WeightUnits weight = await repository.getCurrentWeight();
    DateTime birthday = repository.getBirthday();
    return ProfileState(
        sex: sex,
        activityLevel: activityLevel,
        height: height,
        weight: weight,
        birthday: birthday);
  }

  ProfileState.clone(ProfileState profile,
      {Sex sex,
      ActivityLevel activityLevel,
      LengthUnits height,
      WeightUnits weight,
      DateTime birthday})
      : this(
          sex: sex ?? profile.sex,
          activityLevel: activityLevel ?? profile.activityLevel,
          height: height ?? profile.height,
          weight: weight ?? profile.weight,
          birthday: birthday ?? profile.birthday,
        );

  @override
  List<Object> get props => [sex, activityLevel, height, weight, birthday];
}
