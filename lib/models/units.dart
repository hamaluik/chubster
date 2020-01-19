import 'package:equatable/equatable.dart';

enum BodyWeightUnits { lbs, kgs, stone }
enum EnergyUnits { KCal, KJ }

abstract class WeightUnits extends Equatable {
  final double _grams;
  WeightUnits(this._grams);

  double get _scale => 1.0;
  double get value => _grams * _scale;
}

abstract class Grams extends WeightUnits {
  Grams(double g) : super(g);
  @override double get _scale => 1.0;
}

abstract class KiloGrams extends WeightUnits {
  KiloGrams(double kg) : super(kg * 1000.0);
  @override double get _scale => 0.001;
}

abstract class MilliGrams extends WeightUnits {
  MilliGrams(double mg) : super(mg * 0.001);
  @override double get _scale => 1000.0;
}

abstract class Oz extends WeightUnits {
  Oz(double oz) : super(oz * 28.34952);
  @override double get _scale => 0.03527396;
}

abstract class Lbs extends WeightUnits {
  Lbs(double lbs) : super(lbs * 453.5924);
  @override double get _scale => 0.002204623;
}