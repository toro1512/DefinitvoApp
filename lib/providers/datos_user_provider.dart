import 'package:flutter/material.dart';


class DatosUserProvider extends ChangeNotifier{

  String _nombre="";
  DateTime _fecha=DateTime.now();
  String _sexo="";
  bool _isPintar = false;
  double _peso=0;
  double _altura=0;

  double get peso => _peso;
  double get altura => _altura;
  DateTime get fecha => _fecha;
  String get nombre => _nombre;
  String get sexo => _sexo;
  bool get isPintar => _isPintar;

  set fecha (value){
    _fecha=value;
  }
  set peso (value){
    _peso=value;
  }
  set altura (value){
    _altura=value;
  }
  set nombre(value) {
    _nombre= value;
 }
 set sexo(value) {
    _sexo= value;
 }
 set isPintar( bool value ) {
    _isPintar = value;
    notifyListeners();
  }
}