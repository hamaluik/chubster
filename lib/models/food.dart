import 'package:equatable/equatable.dart';

class Food extends Equatable {
  final String name;
  final double servingSize;
  final String servingSizeUnits;
  final double calories;
  final double fatTotal;
  final double fatSaturated;
  final double fatPolyunsaturated;
  final double fatMonounsaturated;
  final double fatTransaturated;
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
  final double vitaminA;
  final double vitaminC;
  final double caffeine;

  const Food({
    this.name,
    this.servingSize,
    this.servingSizeUnits,
    this.calories,
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
    this.vitaminA,
    this.vitaminC,
    this.caffeine,
  });

  Food.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        servingSize = json['serving_size'],
        servingSizeUnits = json['serving_size_units'],
        calories = json['calories'],
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
        vitaminA = json['vitamin_a'],
        vitaminC = json['vitamin_c'],
        caffeine = json['caffeine'];

  @override
  List<Object> get props => [
        name,
        servingSize,
        servingSizeUnits,
        calories,
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
        vitaminA,
        vitaminC,
        caffeine,
      ];
}
