import 'package:chubster/data_providers/cnf_foods_provider.dart';
import 'package:chubster/data_providers/local_foods_provider.dart';
import 'package:chubster/models/food.dart';
import 'package:flutter/foundation.dart';

class FoodsRepository {
  final LocalFoodsProvider _local;
  final CNFFoodsProvider _cnf;

  FoodsRepository(this._local, this._cnf)
    : assert(_local != null),
      assert(_cnf != null);

  Future<List<Food>> searchForFoodByName(String name, {@required bool localActive, @required bool cnfActive}) async {
    List<Future<List<Food>>> searches = [];
    if(localActive) searches.add(_local.searchForFoodByName(name));
    if(cnfActive) searches.add(_cnf.searchForFoodByName(name));

    List<List<Food>> databaseFoods = await Future.wait(searches);

    // https://stackoverflow.com/questions/15413248/how-to-flatten-a-list
    return databaseFoods.expand((i) => i).toList();
  }

  Future<int> createFood(Food food) async {
    return await _local?.createFood(food);
  }

  static Future<FoodsRepository> open() async {
    LocalFoodsProvider local = await LocalFoodsProvider.open();
    CNFFoodsProvider cnf = await CNFFoodsProvider.open();
    FoodsRepository repo = FoodsRepository(local, cnf);
    return repo;
  }
}
