import 'package:equatable/equatable.dart';

/// A representation of a food item
///
/// Note: all food nutrients are normalized to 100g! Use conversions to convert
/// the values to other amounts
class Food extends Equatable {
  final String name;

  final double energy;
  final double fatTotal;
  final double fatSaturated;
  final double fatTransaturated;
  final double fatPolyunsaturated;
  final double fatMonounsaturated;
  final double cholesterol;
  final double sodium;
  final double carbohydrates;
  final double fiber;
  final double sugars;
  final double protein;
  final double calcium;
  final double potassium;
  final double alcohol;
  final double iron;
  final double caffeine;

  const Food({
    this.name,
    this.energy,
    this.fatTotal,
    this.fatSaturated,
    this.fatPolyunsaturated,
    this.fatMonounsaturated,
    this.fatTransaturated,
    this.cholesterol,
    this.sodium,
    this.carbohydrates,
    this.fiber,
    this.sugars,
    this.protein,
    this.calcium,
    this.potassium,
    this.alcohol,
    this.iron,
    this.caffeine,
  });

  Food.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        energy = json['energy'],
        fatTotal = json['fat_total'],
        fatSaturated = json['fat_saturated'],
        fatPolyunsaturated = json['fat_polyunsaturated'],
        fatMonounsaturated = json['fat_monounsaturated'],
        fatTransaturated = json['fat_transaturated'],
        cholesterol = json['cholesterol'],
        sodium = json['sodium'],
        carbohydrates = json['carbohydrates'],
        fiber = json['fiber'],
        sugars = json['sugars'],
        protein = json['protein'],
        calcium = json['calcium'],
        potassium = json['potassium'],
        alcohol = json['alcohol'],
        iron = json['iron'],
        caffeine = json['caffeine'];

  @override
  List<Object> get props => [
        name,
        energy,
        fatTotal,
        fatSaturated,
        fatPolyunsaturated,
        fatMonounsaturated,
        fatTransaturated,
        cholesterol,
        sodium,
        carbohydrates,
        fiber,
        sugars,
        protein,
        calcium,
        potassium,
        alcohol,
        iron,
        caffeine,
      ];
}
