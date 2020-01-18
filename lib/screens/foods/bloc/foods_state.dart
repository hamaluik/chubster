/*import 'package:equatable/equatable.dart';
import 'package:chubster/models/food.dart';

abstract class FoodsState extends Equatable {
  const FoodsState();
}

class EmptyFoodsState extends FoodsState {
  @override List<Object> get props => [];
}

class SearchingFoodsState extends FoodsState {
  @override List<Object> get props => [];
}

class SearchResultsFoodsState extends FoodsState {
  final List<Food> foods;
  SearchResultsFoodsState(this.foods);

  @override List<Object> get props => [foods];
}

class SearchingFoodsError extends FoodsState {
  @override List<Object> get props => [];
}*/
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