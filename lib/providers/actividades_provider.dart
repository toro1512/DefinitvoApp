import 'package:flutter/material.dart';
import 'package:nutri_saludapp/models/models.dart';

class ActividadesProvider extends ChangeNotifier {

  List <ActividadesFisicas> ocupacionalesSug=[
    ActividadesFisicas(id: 135, nombre: "limpieza, pesada o importante (p. ej., lavar el coche, lavar las ventanas, limpiar el garaje), esfuerzo moderado", typeactivity: 3, met: 3.3),
    ActividadesFisicas(id: 154, nombre: "cocinar o preparar alimentos, esfuerzo moderado", typeactivity: 3, met: 3.5),
    ActividadesFisicas(id: 469, nombre: "sentado, esfuerzo ligero (por ejemplo, trabajo de oficina, trabajo de laboratorio de quimica, trabajo de computadora, reparacion de ensamblaje ligero, reparacion de relojes, lectura, trabajo de escritorio)", typeactivity: 3, met: 8.8),
    ActividadesFisicas(id: 450, nombre: "cocinar o preparar alimentos, esfuerzo moderado", typeactivity: 3, met: 4.5),
    ActividadesFisicas(id: 159, nombre: "guardar comestibles (p. ej., cargar comestibles, comprar sin un carrito de supermercado), transportar paquetes", typeactivity: 3, met: 2.5),

  ];
  List <ActividadesFisicas> deportivasSug=[
    ActividadesFisicas(id: 8, nombre: "andar en bicicleta, montaña, cuesta arriba, vigoroso", typeactivity: 1, met: 14),
    ActividadesFisicas(id: 53, nombre: "ergometro de cinta de correr, general", typeactivity: 1, met: 9),
    ActividadesFisicas(id: 85, nombre: "aerobico, general", typeactivity: 1, met: 7.3),
    ActividadesFisicas(id: 650, nombre: "futbol o beisbol, jugar a la pelota", typeactivity: 1, met: 8),
    ActividadesFisicas(id: 49, nombre: "ejercicio de gimnasio, general", typeactivity: 1, met: 5.5),

  ];
  List <ActividadesFisicas> recreacionalesSug=[
    ActividadesFisicas(id: 247, nombre: "sentado en silencio y viendo la television", typeactivity: 2, met: 1.3),
    ActividadesFisicas(id: 189, nombre: "caminar/correr, jugar con niño(s), esfuerzo vigoroso, solo periodos activos", typeactivity: 3, met: 5.8),
    ActividadesFisicas(id: 95, nombre: "baile general (p. ej., disco, folk, country)", typeactivity: 2, met: 7.8),
    ActividadesFisicas(id: 252, nombre: "sentado, escuchando musica (sin hablar ni leer) o viendo una pelicula en un cine", typeactivity: 2, met: 1.5),
    ActividadesFisicas(id: 163, nombre: "compras no alimentarias, con o sin carrito, de pie o caminando", typeactivity: 3, met: 2.3),

  ];
  List <ActividadesFisicas> todasActividades=[];
  List <ActividadesFisicas> actividadesAlDia=[];
  List <ActividadesFisicasC> actividadesAlDiaHecha=[];
  List <ActividadesFisicasC> ocupacionalesAlDia=[];
  List <ActividadesFisicasC> recreacionalesAlDia=[];
  List <ActividadesFisicasC> deportivasAlDia=[];

final duracionControl = TextEditingController();
bool _intensidadAlta=false;
bool _intensidadMedia=false;
bool _intensidadBaja=false;
int _registrarInt=-1;
String _fechaAc="";

//getters
bool get intensidadAlta => _intensidadAlta;
bool get intensidadMedia => _intensidadMedia;
String get fechaAc => _fechaAc;
bool get intensidadBaja => _intensidadBaja;
int get registrarInt => _registrarInt;



//setters
  set intensidadMedia(value) {
    _intensidadMedia = value;
       }
  set registrarInt(value) {
    _registrarInt = value;
       }     
  set intensidadAlta(value) {
    _intensidadAlta = value;
       }
  set fechaAc(value) {
    _fechaAc= value;
 }     
  set intensidadBaja(value) {
    _intensidadBaja = value;
     }
 void clearVectoresActi(){
  actividadesAlDiaHecha.clear();
  deportivasAlDia.clear();
  recreacionalesAlDia.clear();
  ocupacionalesAlDia.clear();
 }    

 void notiCambiosac(){
  notifyListeners();
 }
}