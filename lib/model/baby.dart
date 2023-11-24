class Baby {
  int? id;
  String? name;
  String? birthdate;
  String? gender;
  String? weight;
  String? height;
  String? headCircumference;
  String? chestCircumference;

  Baby({
    this.id,
    this.name,
    this.birthdate,
    this.gender,
    this.weight,
    this.height,
    this.headCircumference,
    this.chestCircumference,
  });

  // Convert Baby object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthdate': birthdate,
      'gender': gender,
      'weight': weight,
      'height': height,
      'headCircumference': headCircumference,
      'chestCircumference': chestCircumference,
    };
  }

  // Create a Baby object from a Map
  factory Baby.fromMap(Map<String, dynamic> map) {
    return Baby(
      id: map['id'],
      name: map['name'],
      birthdate: map['birthdate'],
      gender: map['gender'],
      weight: map['weight'],
      height: map['height'],
      headCircumference: map['headCircumference'],
      chestCircumference: map['chestCircumference'],
    );
  }

  // Copy a Baby object with optional changes
  Baby copy({
    int? id,
    String? name,
    String? birthdate,
    String? gender,
    String? weight,
    String? height,
    String? headCircumference,
    String? chestCircumference,
  }) {
    return Baby(
      id: id ?? this.id,
      name: name ?? this.name,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      headCircumference: headCircumference ?? this.headCircumference,
      chestCircumference: chestCircumference ?? this.chestCircumference,
    );
  }
}

class Mom {
  int? id;
  int? bottlemilk;
  String? startdate;
  String? expdate;
  String? typefreze;

  Mom({
    this.id,
    this.bottlemilk,
    this.startdate,
    this.expdate,
    this.typefreze,
  });

  // Convert Baby object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bottlemilk': bottlemilk,
      'startdate': startdate,
      'expdate': expdate,
      'typefreze': typefreze,
    };
  }

  // Create a Baby object from a Map
  factory Mom.fromMap(Map<String, dynamic> map) {
    return Mom(
      id: map['id'],
      bottlemilk: map['bottlemilk'],
      startdate: map['startdate'],
      expdate: map['expdate'],
      typefreze: map['typefreze'],
    );
  }

  // Copy a Baby object with optional changes
  Mom copy({
    int? id,
    int? bottlemilk,
    String? startdate,
    String? expdate,
    String? typefreze,
  }) {
    return Mom(
      id: id ?? this.id,
      bottlemilk: bottlemilk ?? this.bottlemilk,
      startdate: startdate ?? this.startdate,
      expdate: expdate ?? this.expdate,
      typefreze: typefreze ?? this.typefreze,
    );
  }
}
