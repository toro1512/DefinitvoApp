import 'dart:convert';

class Alimentos {
    Alimentos({
        required this.id,
        required this.grupo,
        required this.nombre,
        required this.proteina,
        required this.carbohidrato,
        required this.lipids,
        required this.calorias,
        required this.file,
        required this.semaforo,
        required this.amount,
       });

  
    int id;
    String grupo;
    String nombre;
    double proteina;
    double carbohidrato;
    double lipids;
    double calorias;
    String file;
    String semaforo;
    double amount;
    

    
    factory Alimentos.fromJson(String str) => Alimentos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Alimentos.fromMap(Map<String, dynamic> json) => Alimentos(
        id: json["ID"],
        grupo: json["GRUPO"],
        nombre: json["NOMBRE"],
        proteina: json["PROTEINA"].toDouble(),
        carbohidrato: json["CARBOHIDRATO"].toDouble(),
        lipids: json["LIPIDS"].toDouble(),
        calorias: json["CALORIAS"].toDouble(),
        file: json["FILE"],
        semaforo: json["SEMAFORO"],
        amount: 100,
    );

    Map<String, dynamic> toMap() => {
        "ID": id,
        "GRUPO": grupo,
        "NOMBRE": nombre,
        "PROTEINA": proteina,
        "CARBOHIDRATO": carbohidrato,
        "LIPIDS": lipids,
        "CALORIAS": calorias,
        "FILE": file,
        "SEMAFORO": semaforo,
    };
}

