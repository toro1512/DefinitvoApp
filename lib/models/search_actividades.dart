import 'dart:convert';

import 'package:nutri_saludapp/models/models.dart';

class SearchActividades {
    SearchActividades({
        required this.success,
        required this.data,
    });

    int success;
    List<ActividadesFisicas> data;

    factory SearchActividades.fromJson(String str) => SearchActividades.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SearchActividades.fromMap(Map<String, dynamic> json) => SearchActividades(
        success: json["success"],
        data: List<ActividadesFisicas>.from(json["data"].map((x) => ActividadesFisicas.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}
