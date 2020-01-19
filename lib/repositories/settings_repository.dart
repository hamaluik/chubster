import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferences prefs;
  SettingsRepository(this.prefs);

  static Future<SettingsRepository> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return SettingsRepository(prefs);
  }
}