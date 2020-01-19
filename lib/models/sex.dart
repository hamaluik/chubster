enum Sex { male, female, other }

extension SexStr on Sex {
  String get stringify {
    switch(this) {
      case Sex.male: return "Male";
      case Sex.female: return "Female";
      case Sex.other: return "Other";
    }
    return "null";
  }
}