import 'dart:convert';

class Alimentos {
    Alimentos({
        required this.id,
        required this.grupo,
        required this.nombre,
        required this.proteina,
        required this.carbohidrato,
        required this.grasas,
        required this.calorias,
        required this.semaforo,
    });

  
    int id;
    String grupo;
    String nombre;
    double proteina;
    double carbohidrato;
    double grasas;
    double calorias;
    int semaforo;

    
    factory Alimentos.fromJson(String str) => Alimentos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Alimentos.fromMap(Map<String, dynamic> json) => Alimentos(
         id: json["ID"],
        grupo: json["GRUPO"],
        nombre: json["NOMBRE"],
        proteina: json["PROTEINA"].toDouble(),
        carbohidrato: json["CARBOHIDRATO"].toDouble(),
        grasas: json["GRASAS"].toDouble(),
        calorias: json["CALORIAS"].toDouble(),
        semaforo: json["SEMAFORO"],
    );

    Map<String, dynamic> toMap() => {
        "ID": id,
        "GRUPO": grupo,
        "NOMBRE": nombre,
        "PROTEINA": proteina,
        "CARBOHIDRATO": carbohidrato,
        "GRASAS": grasas,
        "CALORIAS": calorias,
        "SEMAFORO": semaforo,
    };
}

