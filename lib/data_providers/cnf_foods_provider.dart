import 'dart:io';
import 'dart:typed_data';
import 'package:chubster/models/food_conversion.dart';
import 'package:chubster/models/food_source.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:chubster/data_providers/foods_provider.dart';
import 'package:chubster/models/food.dart';
import 'package:sqflite/sqflite.dart';

class CNFFoodsProvider extends FoodsProvider {
  final Database _db;

  CNFFoodsProvider(this._db) : assert(_db != null);

  @override
  Future<List<Food>> searchForFoodByName(String name) async {
    List<Map> results = await _db
        .rawQuery('select * from foods where name like ?', ['%$name%']);
    List<Food> foods =
        results.map((food) => Food.fromJson(food, FoodSource.cnf)).toList();
    return foods;
  }

  @override
  Future<List<FoodConversion>> getConversionsForFood(int sourceID) async {
    List<Map> results = await _db.rawQuery("select description, conversion_factor from conversions inner join measurements on measurements.id=conversions.measurement_id where food_id=?", [sourceID]);
    List<FoodConversion> conversions = results.map((row) => FoodConversion(row['description'], row['conversion_factor'])).toList();
    return conversions;
  }

  static Future<CNFFoodsProvider> open() async {
    // get a path to the database file
    var databasesPath = await getDatabasesPath();
    var path = p.join(databasesPath, 'foods.cnf.db');
    var exists = await databaseExists(path);

    // from https://github.com/tekartik/sqflite/blob/master/sqflite/doc/opening_asset_db.md
    if(!exists) {
      print("CNF database not installed, installing now...");
      // make sure the path exists
      await Directory(p.dirname(path)).create(recursive: true);
        
      // copy the database from the asset
      print("Loading cnf.db");
      ByteData data = await rootBundle.load(p.join("assets", "cnf.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      
      // write and flush the bytes written
      print("Copying cnf.db to disk");
      await File(path).writeAsBytes(bytes, flush: true);
      print("Done installing cnf.db!");
    }

    // open the database
    Database db = await openDatabase(path, readOnly: true);
    CNFFoodsProvider repo = CNFFoodsProvider(db);

    return repo;
  }
}
