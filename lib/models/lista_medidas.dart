// To parse this JSON data, do
//
//     final ListaMedidas = ListaMedidasFromMap(jsonString);

import 'dart:convert';

import 'package:nutri_saludapp/models/models.dart';

class ListaMedidas {
    ListaMedidas({
        required this.data,
        required this.success,
    });

    int success;
    List<MedidasTipo> data;

    factory ListaMedidas.fromJson(String str) => ListaMedidas.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ListaMedidas.fromMap(Map<String, dynamic> json) => ListaMedidas(
        success: json["success"],
        data: List<MedidasTipo>.from(json["data"].map((x) => MedidasTipo.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

