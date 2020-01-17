import 'package:chubster/models/food.dart';
import 'package:equatable/equatable.dart';

class FoodsScreenState extends Equatable {
  final String searchTerm;
  final List<Food> matchingFoods;

  FoodsScreenState(this.searchTerm, this.matchingFoods);

  static FoodsScreenState initial() {
    return FoodsScreenState("", []);
  }

  @override
  List<Object> get props => [searchTerm, matchingFoods];
}
