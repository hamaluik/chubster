import 'package:equatable/equatable.dart';

class FoodConversion extends Equatable {
  final String description;
  final double factor;

  FoodConversion(this.description, this.factor);

  @override List<Object> get props => [description, factor];
}