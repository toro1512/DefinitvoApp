// To parse this JSON data, do
//
//     final ValoresHistoria = ValoresFromMap(jsonString);

import 'dart:convert';

class ValoresHistoria {
    ValoresHistoria({
        required this.gastoCalorico,
    });

    double gastoCalorico;

    factory ValoresHistoria.fromJson(String str) => ValoresHistoria.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ValoresHistoria.fromMap(Map<String, dynamic> json) => ValoresHistoria(
        gastoCalorico: json["GASTO_CALORICO"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "GASTO_CALORICO": gastoCalorico,
    };
}