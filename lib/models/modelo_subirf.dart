
class ModelosSubirf{

ModelosSubirf({
  
  required this.user,
  required this.intensidad,
  required this.duracion,
  required this.actividad,
  required this.day,
  required this.calorias
 
});
  
int user;
int intensidad;
int duracion;
String day;
int actividad;
double calorias;

Map<String, dynamic> toJson() => {
      "ID_USERS": user,
      "ID_INTENSITIES": intensidad,
      "DURATION": duracion,
      "DATE_ACTIVITY": day,
      "ID_ACTIVITIES": actividad,
      "KCAL": calorias,
    };
}