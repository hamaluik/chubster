enum ActivityLevel { sedentary, light, moderate, very, extra }

extension ActivityLevelMultipler on ActivityLevel {
  /// Resting energy multiplier
  /// 
  /// From: https://www.iifym.com/tdee-calculator/total-daily-energy-expenditure/what-is-the-tdee-formula-how-is-it-related-to-bmr/
  double get multiplier {
    switch(this) {
      case ActivityLevel.sedentary: return 1.2;
      case ActivityLevel.light: return 1.375;
      case ActivityLevel.moderate: return 1.55;
      case ActivityLevel.very: return 1.725;
      case ActivityLevel.extra: return 1.9;
    }
    return 1.0;
  }
}

extension ActivityLevelStr on ActivityLevel {
  String get stringify {
    switch(this) {
      case ActivityLevel.sedentary: return "Sedentary";
      case ActivityLevel.light: return "Light Activity";
      case ActivityLevel.moderate: return "Moderate Activity";
      case ActivityLevel.very: return "Very Active";
      case ActivityLevel.extra: return "Extra Active";
    }
    return "null";
  }

  String get description {
    switch(this) {
      case ActivityLevel.sedentary: return "little or no exercise";
      case ActivityLevel.light: return "light exercise 1–3 days / week";
      case ActivityLevel.moderate: return "moderate exercise 3–5 days / week";
      case ActivityLevel.very: return "hard exercise 6–7 days / week";
      case ActivityLevel.extra: return "very hard exercise 6–7 days / week + physical job";
    }
    return "null";
  }
}