import 'package:chubster/models/food_source.dart';
import 'package:equatable/equatable.dart';

/// A representation of a food item
///
/// Note: all food nutrients are normalized to 100g! Use conversions to convert
/// the values to other amounts
class Food extends Equatable {
  final int sourceID;
  final String name;
  final FoodSource source;

  /// kCal / 100g
  final double energy;
  
  /// g / 100g
  final double fatTotal;
  
  /// g / 100g
  final double fatSaturated;
  
  /// g / 100g
  final double fatTransaturated;
  
  /// g / 100g
  final double fatPolyunsaturated;
  
  /// g / 100g
  final double fatMonounsaturated;
  
  /// mg / 100g
  final double cholesterol;
  
  /// mg / 100g
  final double sodium;
  
  /// g / 100g
  final double carbohydrates;
  
  /// g / 100g
  final double fiber;
  
  /// g / 100g
  final double sugars;
  
  /// g / 100g
  final double protein;
  
  /// mg / 100g
  final double calcium;
  
  /// mg / 100g
  final double potassium;
  
  /// mg / 100g
  final double iron;
  
  /// g / 100g
  final double alcohol;
  
  /// mg / 100g
  final double caffeine;

  const Food({
    this.sourceID,
    this.name,
    this.source,
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

  Food.fromJson(Map<String, dynamic> json, FoodSource source)
      : name = json['name'],
        sourceID = json['id'],
        source = source,
        energy = json['energy'],
        fatTotal = json['fat_total'],
        fatSaturated = json['fat_saturated'],
        fatPolyunsaturated = json['fat_polyunsaturated'],
        fatMonounsaturated = json['fat_monounsaturated'],
        fatTransaturated = json['fat_transatured'],
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
