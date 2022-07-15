import 'dart:convert';

class MedidasTipo {
    MedidasTipo({
        required this.pmId,
        required this.pmName,
        required this.puId,
        required this.puName,
        required this.typ,
        required this.valor,
        required this.measureDate,
        required this.measureTime,
        required this.valueAlt,
    });

    int pmId;
    String pmName;
    int puId;
    String puName;
    String typ;
    int valor;
    DateTime measureDate;
    String measureTime;
    int valueAlt;

    factory MedidasTipo.fromJson(String str) => MedidasTipo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MedidasTipo.fromMap(Map<String, dynamic> json) => MedidasTipo(
        pmId: json["PM_ID"],
        pmName: json["PM_NAME"],
        puId: json["PU_ID"],
        puName: json["PU_NAME"],
        typ: json["TYP"],
        valor: json["VALOR"],
        measureDate: DateTime.parse(json["MEASURE_DATE"]),
        measureTime: json["MEASURE_TIME"],
        valueAlt: json["VALUE_ALT"],
    );

    Map<String, dynamic> toMap() => {
        "PM_ID": pmId,
        "PM_NAME": pmName,
        "PU_ID": puId,
        "PU_NAME": puName,
        "TYP": typ,
        "VALOR": valor,
        "MEASURE_DATE": measureDate.toIso8601String(),
        "MEASURE_TIME": measureTime,
        "VALUE_ALT": valueAlt,
    };
}
