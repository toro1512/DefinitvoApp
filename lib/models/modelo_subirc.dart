class ModelosSubirc{

ModelosSubirc({

  required this.idUser,
  required this.idFood,
  required this.idFoodMoment,
  required this.amount,
  required this.fecha,
 
});
  
int idUser;
int idFood;
int idFoodMoment;
String fecha;
double amount;

 Map<String, dynamic> toJson() => {
        "ID_USERS": idUser,
        "ID_FOOD_MOMENT": idFoodMoment,
        "ID_FOODS": idFood,
        "AMOUNT": amount,
        "DATE_INTAKE": fecha,
    };

}