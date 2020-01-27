import 'package:chubster/models/food.dart';
import 'package:chubster/models/food_conversion.dart';

abstract class FoodsProvider {
  Future<List<Food>> searchForFoodByName(String name);
  Future<List<FoodConversion>> getConversionsForFood(int sourceID);
}
