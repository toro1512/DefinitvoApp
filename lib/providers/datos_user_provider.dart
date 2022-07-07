import 'package:flutter/material.dart';


class DatosUserProvider extends ChangeNotifier{

  String _nombre="";
  DateTime _fecha=DateTime.now();
  String _sexo="";
  bool _isPintar = false;
  bool _isIMC = false;
  double _peso=0;
  double _altura=0;
  String _imcP="-";
  String _imcPr="-";
   final pesoControl = TextEditingController();
   final alturaControl= TextEditingController();

  double get peso => _peso;
  double get altura => _altura;
  DateTime get fecha => _fecha;
  String get nombre => _nombre;
  String get imcP => _imcP;
  String get imcPr => _imcPr;
  String get sexo => _sexo;
  bool get isPintar => _isPintar;
  bool get isIMC => _isIMC;

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
  set imcP(value) {
    _imcP= value;
 }
  set imcPr(value) {
    _imcPr= value;
 }
 set sexo(value) {
    _sexo= value;
 }
 set isPintar( bool value ) {
    _isPintar = value;
    notifyListeners();
  }
  set isIMC( bool value ) {
    _isIMC = value;
    notifyListeners();
  }

}