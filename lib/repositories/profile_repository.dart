import 'dart:io';
import 'package:chubster/models/sex.dart';
import 'package:chubster/models/units.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class ProfileRepository {
  final Database _db;
  final SharedPreferences _prefs;

  ProfileRepository(this._db, this._prefs);

  LengthUnits getHeight() {
    double height = _prefs.getDouble("height");
    if(height == null) return null;
    return Meters(height);
  }

  void setHeight(LengthUnits height) async {
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

  void setSex(Sex sex) async {
    await _prefs.setString("sex", sex.toString());
  }

  static void _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<KiloGrams> getCurrentWeight() async {
    var results = await _db.rawQuery("select weight from weights order by timestamp desc limit 1");
    if(results.length > 0) {
      double weight = results[0]["weight"];
      return KiloGrams(weight);
    }
    return null;
  }

  void recordWeight(WeightUnits weight) async {
    await _db.rawInsert("insert into weights(weight) values(?)", [weight.toKiloGrams().value]);
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('''
      create table weights(
        weight real not null,
        timestamp integer not null default current_timestamp
      )
    ''');
  }

  static Future<ProfileRepository> open() async {
    // get a path to the database file
    var databasesPath = await getDatabasesPath();
    var path = p.join(databasesPath, 'chubster.profile.db');
    await Directory(databasesPath).create(recursive: true);

    // open the database
    Database db = await openDatabase(path,
        onConfigure: _onConfigure, onCreate: _onCreate, version: 1);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ProfileRepository repo = ProfileRepository(db, prefs);

    return repo;
  }
}
