import 'package:chubster/data_providers/profile_provider.dart';
import 'package:chubster/models/measurement.dart';
import 'package:chubster/models/sex.dart';
import 'package:chubster/models/units.dart';
import 'package:chubster/models/weight_measurement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  final ProfileProvider _profile;
  final SharedPreferences _prefs;

  ProfileRepository(this._profile, this._prefs)
    : assert(_profile != null)
    , assert(_prefs != null);

  DateTime getBirthday() {
    int ts = _prefs.getInt("birthday");
    if(ts == null) {
      return DateTime.now().subtract(Duration(days: (365.25 * 30.0).ceil()));
    }
    return DateTime.fromMillisecondsSinceEpoch(ts);
  }

  Future<void> setBirthday(DateTime birthday) async {
    int ts = birthday.millisecondsSinceEpoch;
    await _prefs.setInt("birthday", ts);
  }

  LengthUnits getHeight() {
    double height = _prefs.getDouble("height");
    if(height == null) return null;
    return Meters(height);
  }

  Future<void> setHeight(LengthUnits height) async {
    await _prefs.setDouble("height", height.toMeters().value);
  }

  Sex getSex() {
    String sexStr = _prefs.getString("sex");
    Sex sex = Sex.other;
    if(sexStr != null) {
      sex = Sex.values.firstWhere((e) => e.toString() == sexStr);
    }
    return sex;
  }

  Future<void> setSex(Sex sex) async {
    await _prefs.setString("sex", sex.toString());
  }

  Future<WeightUnits> getCurrentWeight() async {
    WeightMeasurement measurement = await _profile.getLatestWeight();
    return measurement?.weight;
  }

  Future<void> recordWeight(WeightUnits weight) async {
    await _profile.recordWeight(weight);
  }

  static Future<ProfileRepository> open() async {
    List<dynamic> futures = await Future.wait([ProfileProvider.open(), SharedPreferences.getInstance()]);
    ProfileRepository repo = ProfileRepository(futures[0], futures[1]);

    return repo;
  }
}
