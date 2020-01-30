import 'dart:io';
import 'package:chubster/models/food_conversion.dart';
import 'package:path/path.dart' as p;
import 'package:chubster/data_providers/foods_provider.dart';
import 'package:chubster/models/food.dart';
import 'package:chubster/models/food_source.dart';
import 'package:sqflite/sqflite.dart';

class LocalFoodsProvider extends FoodsProvider {
  final Database _db;

  LocalFoodsProvider(this._db) : assert(_db != null);

  static void _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('''
      create table foods(
        id integer not null primary key autoincrement,
        name text not null,
        energy real default null, -- kCal / 100g
        fat_total real default null, -- g / 100g
        fat_saturated real default null, -- g / 100g
        fat_transaturated real default null, -- g / 100g
        fat_polyunsaturated real default null, -- g / 100g
        fat_monounsaturated real default null, -- g / 100g
        cholesterol real default null, -- mg / 100g
        sodium real default null, -- mg / 100g
        carbohydrates real default null, -- g / 100g
        fiber real default null, -- g / 100g
        sugars real default null, -- g / 100g
        protein real default null, -- g / 100g
        calcium real default null, -- mg / 100g
        potassium real default null, -- mg / 100g
        iron real default null, -- mg / 100g
        alcohol real default null, -- g / 100g
        caffeine real default null -- mg / 100g
      )
    ''');
    await db.execute('''
      create index food_name on foods(name)
    ''');
    await db.execute('''
      create table measurements(
          id integer not null primary key autoincrement,
          description text not null
        )
    ''');
    await db.execute('''
      create table conversions(
        food_id integer not null,
        measurement_id integer not null,
        conversion_factor real not null,
        unique(food_id, measurement_id),
        foreign key(food_id) references foods(id),
        foreign key(measurement_id) references measurements(id)
      )
    ''');
    await db.execute('''
      create index conversions_food_id on conversions(food_id)
    ''');
  }

  static Future<LocalFoodsProvider> open() async {
    // get a path to the database file
    var databasesPath = await getDatabasesPath();
    var path = p.join(databasesPath, 'foods.user.db');
    await Directory(databasesPath).create(recursive: true);

    // open the database
    Database db = await openDatabase(path,
        onConfigure: _onConfigure, onCreate: _onCreate, version: 1);
    LocalFoodsProvider repo = LocalFoodsProvider(db);

    print("Compile options:");
    List<Map> compileOptions = await db.rawQuery("pragma compile_options");
    print(compileOptions.toString());
    for(Map<String, dynamic> compileOption in compileOptions) {
      print(compileOption['compile_options']);
    }
    print("</ compile options");

    return repo;
  }

  @override
  Future<List<Food>> searchForFoodByName(String name) async {
    List<Map> results = await _db
        .rawQuery('select * from foods where name like ?', ['%$name%']);
    List<Food> foods =
        results.map((food) => Food.fromJson(food, FoodSource.local)).toList();
    return foods;
  }

  Future<int> createFood(Food food) async {
    // TODO: implement createFood
    throw Exception("createFood is not implemented yet!");
  }

  @override
  Future<List<FoodConversion>> getConversionsForFood(int sourceID) async {
    // TODO: local conversions
    return List<FoodConversion>();
  }
}
