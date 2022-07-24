// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);


import 'dart:convert';

class ActividadesFisicas {
    ActividadesFisicas({
        required this.id,
        required this.nombre,
        required this.typeactivity,
        required this.met,
        this.calorias,
        this.duracion,
        this.intensidad,
    });

    int id;
    String nombre;
    int typeactivity;
    double met;
    double? calorias;
    int? duracion;
    int? intensidad;

    factory ActividadesFisicas.fromJson(String str) => ActividadesFisicas.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ActividadesFisicas.fromMap(Map<String, dynamic> json) => ActividadesFisicas(
        id: json["ID"],
        nombre: json["NOMBRE"],
        typeactivity: json["TYPEACTIVITY"],
        met: json["MET"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "ID": id,
        "NOMBRE": nombre,
        "TYPEACTIVITY": typeactivity,
        "MET": met,
    };
}
