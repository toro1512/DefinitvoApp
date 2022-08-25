// To parse required this JSON data, do
//
//     final ListaFisica = ListaFisicaFromMap(jsonString);

import 'dart:convert';

import 'package:nutri_saludapp/models/models.dart';

class ListaFisica {
    ListaFisica({
        required this.success,
        required this.data,
    });

    int success;
    List<ActividadesFisicasC> data;

    factory ListaFisica.fromJson(String str) => ListaFisica.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ListaFisica.fromMap(Map<String, dynamic> json) => ListaFisica(
        success: json["success"],
        data: List<ActividadesFisicasC>.from(json["data"].map((x) => ActividadesFisicasC.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

