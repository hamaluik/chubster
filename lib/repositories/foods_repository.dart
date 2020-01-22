import 'dart:io';
import 'package:chubster/models/food.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class FoodsRepository {
  final Database _user;

  FoodsRepository(this._user);

  Future<List<Food>> searchForFoodByName(String name) async {
    List<Map> results = await _user.rawQuery('select * from foods where name like ?', ['%$name%']);
    List<Food> foods = results.map((food) => Food.fromJson(food)).toList();
    return foods;
  }

  Future<int> createFood(Food food) async {
    int rowid = await _user.rawInsert("insert into foods(name, energy, fat_total, fat_saturated, fat_polyunsaturated, fat_monounsaturated, cholesterol, sodium, carbohydrates, fiber, sugars, protein, calcium, potassium, alcohol, iron, caffeine) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", food.props);
    return rowid;
  }

  static void _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('''
      create table foods(
        id integer not null primary key autoincrement,
        name text not null,
        energy real default null,
        fat_total real default null,
        fat_saturated real default null,
        fat_trans real default null,
        fat_polyunsaturated real default null,
        fat_monounsaturated real default null,
        cholesterol real default null,
        sodium real default null,
        carbohydrates real default null,
        fiber real default null,
        sugars real default null,
        protein real default null,
        calcium real default null,
        potassium real default null,
        iron real default null,
        alcohol real default null,
        caffeine real default null
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

  static Future<FoodsRepository> open() async {
    // get a path to the database file
    var databasesPath = await getDatabasesPath();
    var path = p.join(databasesPath, 'foods.user.db');
    await Directory(databasesPath).create(recursive: true);

    // open the database
    Database db = await openDatabase(path,
        onConfigure: _onConfigure, onCreate: _onCreate, version: 1);
    FoodsRepository repo = FoodsRepository(db);

    return repo;
  }
}
