// To parse this JSON data, do
//
//     final searchAlimentos = searchAlimentosFromMap(jsonString);

import 'dart:convert';
import 'package:nutri_saludapp/models/models.dart';

class SearchAlimentos {
    SearchAlimentos({
      required this.page,
       required this.results,
       
    });

     int page;
    List<Alimentos> results;
  

    factory SearchAlimentos.fromJson(String str) => SearchAlimentos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SearchAlimentos.fromMap(Map<String, dynamic> json) => SearchAlimentos(
        page: json["page"],
        results: List<Alimentos>.from(json["result"].map((x) => Alimentos.fromMap(x))),
       
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
     
    };
}