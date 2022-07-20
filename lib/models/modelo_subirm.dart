import 'dart:convert';

class ModelosSubirm {
   ModelosSubirm({
        required this.idUsers,
        required this.idPhysicalMeasures,
        required this.beforeAfter,
        required this.value,
        required this.measureDate,
        required this.measureTime,
        required this.valueAlt,
    });

    int idUsers;
    int idPhysicalMeasures;
    int beforeAfter;
    int value;
    String measureDate;
    String measureTime;
    int valueAlt;

    factory ModelosSubirm.fromJson(String str) => ModelosSubirm.fromMap(json.decode(str));
    
    
    
    factory ModelosSubirm.fromMap(Map<String, dynamic> json) => ModelosSubirm(
        idUsers: json["idUsers"],
        idPhysicalMeasures: json["idPhysicalMeasures"],
        beforeAfter: json["beforeAfter"],
        value: json["value"].toDouble(),
        measureDate: json["MEASURE_DATE"],
        measureTime: json["MEASURE_TIME"],
        valueAlt: json["VALUE_ALT"].toDouble(),
    );
   
    Map<String, dynamic> toJson() => {
        "ID_USERS": idUsers,
        "ID_PHYSICAL_MEASURES": idPhysicalMeasures,
        "BEFORE_AFTER": beforeAfter,
        "VALUE": value,
        "MEASURE_DATE": measureDate,
        "MEASURE_TIME": measureTime,
        "VALUE_ALT": valueAlt,
    };
    
}
