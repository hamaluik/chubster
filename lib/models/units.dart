import 'package:equatable/equatable.dart';

abstract class Units extends Equatable {
  String get unitsStr;
}

abstract class WeightUnits extends Units {
  final double _grams;
  WeightUnits(this._grams);

  List<Object> get props => [_grams];
  double get _scale => 1.0;
  double get value => _grams * _scale;
  @override String get unitsStr => "g";

  Grams toGrams() => this;
  KiloGrams toKiloGrams() => this;
  MilliGrams toMilliGrams() => this;
  Oz toOz() => this;
  Lbs toLbs() => this;
}

class Grams extends WeightUnits {
  Grams(double g) : super(g);
  @override double get _scale => 1.0;
  @override String get unitsStr => "g";
}

class KiloGrams extends WeightUnits {
  KiloGrams(double kg) : super(kg * 1000.0);
  @override double get _scale => 0.001;
  @override String get unitsStr => "kg";
}

class MilliGrams extends WeightUnits {
  MilliGrams(double mg) : super(mg * 0.001);
  @override double get _scale => 1000.0;
  @override String get unitsStr => "mg";
}

class Oz extends WeightUnits {
  Oz(double oz) : super(oz * 28.34952);
  @override double get _scale => 0.03527396;
  @override String get unitsStr => "oz";
}

class Lbs extends WeightUnits {
  Lbs(double lbs) : super(lbs * 453.5924);
  @override double get _scale => 0.002204623;
  @override String get unitsStr => "lbs";
}

abstract class LengthUnits extends Units {
  final double _meters;
  LengthUnits(this._meters);

  List<Object> get props => [_meters];
  double get _scale => 1.0;
  double get value => _meters * _scale;
  @override String get unitsStr => "m";

  Meters toMeters() => Meters(this._meters);
  CentiMeters toCentiMeters() => CentiMeters(this._meters * 100.0);
  Feet toFeet() => Feet(this._meters * 3.28084);
  Inches toInches() => Inches(this._meters * 39.37008);
}

class Meters extends LengthUnits {
  Meters(double m) : super(m);
  @override double get _scale => 1.0;
  @override String get unitsStr => "m";
}

class CentiMeters extends LengthUnits {
  CentiMeters(double cm) : super(cm * 0.01);
  @override double get _scale => 100.0;
  @override String get unitsStr => "cm";
}

class Feet extends LengthUnits {
  Feet(double ft) : super(ft * 0.3048);
  @override double get _scale => 3.28084;
  @override String get unitsStr => "ft";
}

class Inches extends LengthUnits {
  Inches(double inches) : super(inches * 0.0254);
  @override double get _scale => 39.37008;
  @override String get unitsStr => "in";
}
