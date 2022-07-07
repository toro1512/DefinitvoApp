// To parse this JSON data, do
//
//     final searchAlimentos = searchAlimentosFromMap(jsonString);

import 'dart:convert';
import 'package:nutri_saludapp/models/models.dart';

class SearchAlimentos {
    SearchAlimentos({
      required this.success,
      required this.data,
       
    });

    int success;
    List<Alimentos> data;
  

    factory SearchAlimentos.fromJson(String str) => SearchAlimentos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SearchAlimentos.fromMap(Map<String, dynamic> json) => SearchAlimentos(
        success: json["success"],
        data: List<Alimentos>.from(json["data"].map((x) => Alimentos.fromMap(x))),
       
    );

    Map<String, dynamic> toMap() => {
        "page": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
     
    };
}