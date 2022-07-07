// To parse this JSON data, do
//
//     final searchAlimentos = searchAlimentosFromMap(jsonString);

import 'dart:convert';
import 'package:nutri_saludapp/models/models.dart';

class ListaAlimentos {
    ListaAlimentos({
        required this.success,
        required this.data,
    });

    int success;
    List<AlimentosDia> data;

    factory ListaAlimentos.fromJson(String str) => ListaAlimentos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ListaAlimentos.fromMap(Map<String, dynamic> json) => ListaAlimentos(
        success: json["success"],
        data: List<AlimentosDia>.from(json["data"].map((x) =>AlimentosDia.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

