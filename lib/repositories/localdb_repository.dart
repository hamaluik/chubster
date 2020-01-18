import 'dart:io';
import 'package:chubster/models/food.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class LocalDBRepository {
  final Database _db;

  LocalDBRepository(this._db);

  Future<List<Food>> searchForFoodByName(String name) async {
    List<Map> results = await _db.rawQuery('select * from foods where name like ?', ['%$name%']);
    List<Food> foods = results.map((food) => Food.fromJson(food)).toList();
    return foods;
  }

  Future<int> createFood(Food food) async {
    int rowid = await _db.rawInsert("insert into foods(name, serving_size, serving_size_units, calories, fat_total, fat_saturated, fat_polyunsaturated, fat_monounsaturated, cholesterol, sodium, carbohydrates, fiber, sugars, protein, calcium, potassium, alcohol, iron, vitamin_a, vitamin_c, caffeine) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", food.props);
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
        serving_size real not null,
        serving_size_units text default null,
        calories real default null,
        fat_total real default null,
        fat_saturated real default null,
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
        alcohol real default null,
        iron real default null,
        vitamin_a real default null,
        vitamin_c real default null,
        caffeine real default null
      )
    ''');

    await db.execute('''
      create index food_name_index on foods(name)
    ''');

    // todo: remove this testing code
    Food chicken = Food(
      name: "Chicken Breast",
      servingSize: 4.2,
      servingSizeUnits: "oz",
      calories: 142,
      fatTotal: 3.1,
      fatSaturated: 0.9,
      fatPolyunsaturated: 0.7,
      fatMonounsaturated: 1.1,
      cholesterol: 73,
      sodium: 64,
      carbohydrates: 0,
      fiber: 0,
      sugars: 0,
      protein: 26.7,
      calcium: 13,
      potassium: 220,
      alcohol: 0,
      iron: 1,
      vitaminA: 17,
      vitaminC: 0,
      caffeine: 0,
    );
    await db.rawInsert("insert into foods(name, serving_size, serving_size_units, calories, fat_total, fat_saturated, fat_polyunsaturated, fat_monounsaturated, cholesterol, sodium, carbohydrates, fiber, sugars, protein, calcium, potassium, alcohol, iron, vitamin_a, vitamin_c, caffeine) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", chicken.props);
  }

  static Future<LocalDBRepository> open() async {
    // get a path to the database file
    var databasesPath = await getDatabasesPath();
    var path = p.join(databasesPath, 'chubster.local.db');
    await Directory(databasesPath).create(recursive: true);

    // open the database
    Database db = await openDatabase(path,
        onConfigure: _onConfigure, onCreate: _onCreate, version: 1);
    LocalDBRepository repo = LocalDBRepository(db);

    return repo;
  }
}
