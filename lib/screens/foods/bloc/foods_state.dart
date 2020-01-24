import 'package:chubster/models/food.dart';

abstract class FoodsState {
  const FoodsState();
}

class EmptyFoodsState extends FoodsState {
}

class SearchingFoodsState extends FoodsState {
}

class SearchResultsFoodsState extends FoodsState {
  final List<Food> foods;
  SearchResultsFoodsState(this.foods);
}

class SearchingFoodsError extends FoodsState {
}