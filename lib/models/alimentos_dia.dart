import 'dart:convert';

class AlimentosDia {
    AlimentosDia({
        required this.moment,
        required this.food,
        required this.amount,
        required this.kcal,
        required this.light,
    });

    String moment;
    String food;
    int amount;
    int kcal;
    String light;

    factory AlimentosDia.fromJson(String str) => AlimentosDia.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AlimentosDia.fromMap(Map<String, dynamic> json) => AlimentosDia(
        moment: json["MOMENT"],
        food: json["FOOD"],
        amount: json["AMOUNT"],
        kcal: json["KCAL"],
        light: json["LIGHT"],
    );

    Map<String, dynamic> toMap() => {
        "MOMENT": moment,
        "FOOD": food,
        "AMOUNT": amount,
        "KCAL": kcal,
        "LIGHT": light,
    };
}
