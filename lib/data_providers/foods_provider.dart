import 'package:chubster/models/food.dart';

abstract class FoodsProvider {
  Future<List<Food>> searchForFoodByName(String name);
}
