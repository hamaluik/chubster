import 'dart:io';
import 'package:chubster/models/measurement.dart';
import 'package:chubster/models/units.dart';
import 'package:chubster/models/weight_measurement.dart';
import 'package:path/path.dart' as p;
import 'package:chubster/models/food.dart';
import 'package:sqflite/sqflite.dart';

class ProfileProvider {
  final Database _db;

  ProfileProvider(this._db) : assert(_db != null);

  Future<void> recordFood(Food food, double amountInGrams, String meal) async {
    // convert all values based on the amount
    double energy = food.energy == null ? null : (food.energy * 100.0 / amountInGrams);
    double fatTotal = food.fatTotal == null ? null : (food.fatTotal * 100.0 / amountInGrams);
    double fatSaturated = food.fatSaturated == null ? null : (food.fatSaturated * 100.0 / amountInGrams);
    double fatTransaturated = food.fatTransaturated == null ? null : (food.fatTransaturated * 100.0 / amountInGrams);
    double fatPolyunsaturated = food.fatPolyunsaturated == null ? null : (food.fatPolyunsaturated * 100.0 / amountInGrams);
    double fatMonounsaturated = food.fatMonounsaturated == null ? null : (food.fatMonounsaturated * 100.0 / amountInGrams);
    double cholesterol = food.cholesterol == null ? null : (food.cholesterol * 100.0 / amountInGrams);
    double sodium = food.sodium == null ? null : (food.sodium * 100.0 / amountInGrams);
    double carbohydrates = food.carbohydrates == null ? null : (food.carbohydrates * 100.0 / amountInGrams);
    double fiber = food.fiber == null ? null : (food.fiber * 100.0 / amountInGrams);
    double sugars = food.sugars == null ? null : (food.sugars * 100.0 / amountInGrams);
    double protein = food.protein == null ? null : (food.protein * 100.0 / amountInGrams);
    double calcium = food.calcium == null ? null : (food.calcium * 100.0 / amountInGrams);
    double potassium = food.potassium == null ? null : (food.potassium * 100.0 / amountInGrams);
    double iron = food.iron == null ? null : (food.iron * 100.0 / amountInGrams);
    double alcohol = food.alcohol == null ? null : (food.alcohol * 100.0 / amountInGrams);
    double caffeine = food.caffeine == null ? null : (food.caffeine * 100.0 / amountInGrams);

    await _db.rawInsert('''
      insert into diet(name, meal, foods_source, foods_source_id, amount, energy, fat_total, fat_saturated, fat_transaturated, fat_polyunsaturated, fat_monounsaturated, cholesterol, sodium, carbohydrates, fiber, sugars, protein, calcium, potassium, iron, alcohol, caffeine) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      food.name, meal, food.source.toString(), food.sourceID, amountInGrams, energy, fatTotal, fatSaturated, fatTransaturated, fatPolyunsaturated, fatMonounsaturated, cholesterol, sodium, carbohydrates, fiber, sugars, protein, calcium, potassium, iron, alcohol, caffeine,
    ]);
  }

  Future<void> recordWeight(WeightUnits weight) async {
    double weightInKg = weight.toKiloGrams().value;
    await _db.rawInsert("insert into weights(value) values(?)", [weightInKg]);
  }

  Future<WeightMeasurement> getLatestWeight() async {
    List<Map<String, dynamic>> rows = await _db.rawQuery("select value, strftime('%s',timestamp) as timestamp from weights order by timestamp desc limit 1");
    if(rows == null || rows.length == 0) return null;
    double value = rows[0]['value'];
    String ts = rows[0]['timestamp'];
    int time = int.parse(ts);
    DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(time * 1000, isUtc: true);
    return WeightMeasurement(
      weight: KiloGrams(value),
      timestamp: timestamp,
    );
  }

  Future<List<WeightMeasurement>> getWeights({DateTime start, DateTime end}) async {
    throw Exception("Not implemented yet");
  }

  Future<void> recordLengthMeasurement(String measurement, LengthUnits length) async {
    double lengthInCM = length.toCentiMeters().value;
    await _db.rawInsert("insert into measurements(measurement, value) values(?, ?)", [measurement, lengthInCM]);
  }

  Future<Measurement> getLatestMeasurement(String name) async {
    throw Exception("Not implemented yet");
  }

  Future<List<Measurement>> getMeasurements(String nane, {DateTime start, DateTime end}) async {
    throw Exception("Not implemented yet");
  }

  static void _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('''
      create table diet(
        timestamp text not null default current_timestamp, -- when the food was consumed
        name text not null, -- the name of the food that was consumed
        meal text default null, -- an optional meal to associate the food with
        foods_source text not null, -- the textual representation of the food source database
        foods_source_id integer not null, -- the primary key of the food in the given food source database
        amount real default null, -- g (the number of grams that we consumed, all nutrient values are raw totals, pre-adjusted using this amount)
        energy real default null, -- kCal
        fat_total real default null, -- g
        fat_saturated real default null, -- g
        fat_transaturated real default null, -- g
        fat_polyunsaturated real default null, -- g
        fat_monounsaturated real default null, -- g
        cholesterol real default null, -- mg
        sodium real default null, -- mg
        carbohydrates real default null, -- g
        fiber real default null, -- g
        sugars real default null, -- g
        protein real default null, -- g
        calcium real default null, -- mg
        potassium real default null, -- mg
        iron real default null, -- mg
        alcohol real default null, -- g
        caffeine real default null -- mg
      )
    ''');
    await db.execute('''
      create index diet_times on diet(timestamp)
    ''');
    await db.execute('''
      create table weights(
        value real not null,
        timestamp text not null default current_timestamp
      )
    ''');
    await db.execute('''
      create index weights_timestamp on weights(timestamp)
    ''');
    await db.execute('''
      create table measurements(
        measurement text not null,
        value real not null,
        timestamp text not null default current_timestamp
      )
    ''');
    await db.execute('''
      create index measurements_measurement on measurements(measurement)
    ''');
    await db.execute('''
      create index measurements_measurement_timestamp on measurements(measurement, timestamp)
    ''');
  }

  static Future<ProfileProvider> open() async {
    // get a path to the database file
    var databasesPath = await getDatabasesPath();
    var path = p.join(databasesPath, 'profile.db');
    await Directory(databasesPath).create(recursive: true);

    // open the database
    Database db = await openDatabase(path,
        onConfigure: _onConfigure, onCreate: _onCreate, version: 1);
    ProfileProvider repo = ProfileProvider(db);

    return repo;
  }
}
