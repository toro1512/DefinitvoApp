// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);


import 'dart:convert';

class ActividadesFisicasC {
    ActividadesFisicasC({
        required this.id,
        required this.nombre,
        required this.typeactivity,
        required this.met,
        this.kquemadas,
        this.duration,
        this.intensities,
    });

    int id;
    String nombre;
    int typeactivity;
    double met;
    double? kquemadas;
    int? duration;
    int? intensities;
    

    factory ActividadesFisicasC.fromJson(String str) => ActividadesFisicasC.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ActividadesFisicasC.fromMap(Map<String, dynamic> json) => ActividadesFisicasC(
        id: json["ID"],
        nombre: json["NOMBRE"],
        typeactivity: json["TYPEACTIVITY"],
        met: json["MET"].toDouble(),
        duration: json["DURATION"],
        kquemadas: json["KQUEMADAS"].toDouble(),
        intensities: json["INTENSITIES"],
    );

    Map<String, dynamic> toMap() => {
        "ID": id,
        "NOMBRE": nombre,
        "TYPEACTIVITY": typeactivity,
        "MET": met,
        "DURATION": duration,
        "KQUEMADAS": kquemadas,
        "INTENSITIES": intensities,
    };
}
