// To parse this JSON data, do
//
//     final MedidasCargar = MedidasCargarFromMap(jsonString);

import 'dart:convert';

class MedidasCargar {
    MedidasCargar({
        required this.success,
        required this.data,
    });

    int success;
    List<Medidas> data;

    factory MedidasCargar.fromJson(String str) => MedidasCargar.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MedidasCargar.fromMap(Map<String, dynamic> json) => MedidasCargar(
        success: json["success"],
        data: List<Medidas>.from(json["data"].map((x) => Medidas.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Medidas {
    Medidas({
        required this.pmId,
        required this.pmName,
        required this.puId,
        required this.puName,
        required this.typ,
    });

    int pmId;
    String pmName;
    int puId;
    String puName;
    String typ;

    factory Medidas.fromJson(String str) => Medidas.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Medidas.fromMap(Map<String, dynamic> json) => Medidas(
        pmId: json["PM_ID"],
        pmName: json["PM_NAME"],
        puId: json["PU_ID"],
        puName: json["PU_NAME"],
        typ: json["TYP"],
    );

    Map<String, dynamic> toMap() => {
        "PM_ID": pmId,
        "PM_NAME": pmName,
        "PU_ID": puId,
        "PU_NAME": puName,
        "TYP": typ,
    };
}
