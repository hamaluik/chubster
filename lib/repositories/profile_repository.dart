import 'dart:io';
import 'package:chubster/models/metric.dart';
import 'package:chubster/models/sex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class ProfileRepository {
  final Database _db;
  final SharedPreferences _prefs;

  ProfileRepository(this._db, this._prefs);

  void recordMetric(Metric metric) async {
    await _db.rawInsert(
        "insert into metrics(metric, value, units, timestamp) values(?, ?, ?, datetime('now'))",
        [metric.name, metric.value, metric.units.unitsStr]);
  }

  double getHeight() {
    return _prefs.getDouble("height") ?? 0.0;
  }

  void setHeight(double height) async {
    await _prefs.setDouble("height", height);
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

  static void _onCreate(Database db, int version) async {
    await db.execute('''
      create table metrics(
        id integer not null primary key autoincrement,
        metric text not null,
        units text not null,
        value real not null,
        timestamp integer not null
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
