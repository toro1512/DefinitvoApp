import 'package:flutter/material.dart';
import 'package:nutri_saludapp/models/models.dart';

class GeneralProvider extends ChangeNotifier{

 List <Alimentos> almuerosLista= [];
 List <Alimentos> desayunosLista= [];
 List <Alimentos> cenasLista= [];
 List <Alimentos> meriendasLista= [];
 List <AlimentosDia> alimentosDay= [];
 List <AlimentosDia> almLisDay= [];
 List <AlimentosDia> cenLisDay= [];
 List <AlimentosDia> merLisDay= [];
 List <AlimentosDia> desLisDay= [];
 List <Medidas> medidasTomar= [];
 List <Medidas> medidasFisicas= [];
 
  List <Alimentos> almuerosSuge= [
  Alimentos(id:3774,grupo:"6",nombre:"Cerdo lomo horneado sin sal",proteina:35.1,carbohidrato:0,lipids:3.2,calorias:170, semaforo: "1", file: "assets/PLATO"),
  Alimentos(id:4714,grupo:"6",nombre:"Res lomo cocido sin sal ",proteina:36.1,carbohidrato:0,lipids:7.9,calorias:218, semaforo: "2", file: "assets/PLATO"),
  Alimentos(id:94,grupo:"1",nombre:"Arroz blanco pulido cocido sin sal ",proteina:2.3,carbohidrato:30.9,lipids:2.1,calorias:161, semaforo:"1", file: "assets/PLATO"),
  Alimentos(id:714,grupo:"1",nombre:"Pasta alimenticia, con huevo, sin enriquecer, coci",proteina:4.5,carbohidrato:24.3,lipids:1,calorias:132, semaforo: "1", file: "assets/PLATO"),
  Alimentos(id:1954,grupo:"2",nombre:"Yuca blanca sin cáscara cocida sin sal ",proteina:0.7,carbohidrato:33.9,lipids:0.2,calorias:157, semaforo: "2", file: "assets/PLATO"),
  Alimentos(id:1534,grupo:"2",nombre:"Papa variedad cerosa sabanera con cáscara cocida s",proteina:2.3,carbohidrato:18.7,lipids:0.1,calorias:99, semaforo: "3", file: "assets/PLATO"),
 ];
 List <Alimentos> desayunosSuge= [
   Alimentos(nombre: "Huevo de gallina entero revuelto con sal",id:5424,grupo:" 9" , proteina: 10.2, carbohidrato: 0,lipids: 11.4, calorias: 152, semaforo: "1", file: "assets/PLATO" ),
   Alimentos(nombre: "Huevo de gallina entero frito sin sal",id:5414,grupo: "9" , proteina: 17.1, carbohidrato: 0,lipids: 14.6, calorias: 208, semaforo: "1", file: "assets/PLATO" ),
   Alimentos(id:154,grupo:"1",nombre:"Cereal para el desayuno hojuelas de maíz sin azúca ",proteina:8.1,carbohidrato:81.7,lipids:0.4,calorias:383, semaforo: "2", file: "assets/PLATO"),
   Alimentos(id:604,grupo:"1",nombre:"Pan blanco, regular, horneado",proteina:8.9,carbohidrato:45.6,lipids:3.4,calorias:268, semaforo: "1", file: "assets/PLATO"),
   Alimentos(id:44,grupo:"1",nombre:"Arepa de maíz precocido con sal ",proteina:3.3,carbohidrato:34.1,lipids:0.9,calorias:163, semaforo: "2", file: "assets/PLATO"),
   Alimentos(id:74,grupo:"1",nombre:"Arepa de maíz con queso asada",proteina:4.8,carbohidrato:0,lipids:8.4,calorias:211, semaforo: "1", file: "assets/PLATO"),
   Alimentos(id:84,grupo:"1",nombre:"Arepa de maíz frita ",proteina:3.4,carbohidrato:0,lipids:20.3,calorias:325, semaforo: "1", file: "assets/PLATO")
 ];
 List <Alimentos> cenasSuge= [
  Alimentos(id:84,grupo:"1",nombre:"Arepa de maíz frita ",proteina:3.4,carbohidrato:0,lipids:20.3,calorias:325, semaforo: "1", file: "assets/PLATO"),
  Alimentos(id:44,grupo:"1",nombre:"Arepa de maíz precocido con sal ",proteina:3.3,carbohidrato:34.1,lipids:0.9,calorias:163, semaforo: "1", file: "assets/PLATO"),
  Alimentos(id:5044,grupo:"8",nombre:"Queso fresco blando magro tipo suero costeño",proteina:11,carbohidrato:0,lipids:1.5,calorias:83, semaforo: "1", file: "assets/PLATO"),
  Alimentos(id:5074,grupo:"8",nombre:"Queso fresco semiduro semigraso tipo costeño",proteina:17.5,carbohidrato:0,lipids:25.5,calorias:303, semaforo: "2", file: "assets/PLATO"),
  Alimentos(id:6064,grupo:"14",nombre:"Yogurt bebible descremado sin azucar",proteina:3.7,carbohidrato:7.9,lipids:0.3,calorias:49, semaforo: "1", file: "assets/PLATO"),
  Alimentos(id:4084,grupo:"6",nombre:"Jamon de cerdo y res tipo sanduche precocido",proteina:11.4,carbohidrato:0,lipids:15.5,calorias:215, semaforo: "2", file: "assets/PLATO"),
 ];
 List <Alimentos> meriendasSuge= [
  Alimentos(id:164, grupo:"1", nombre:"croissant de queso horneado", proteina:9.2, carbohidrato:46.3, lipids:23, calorias:445, semaforo: "2", file: "assets/PLATO"),
  Alimentos(id:654,grupo:"1",nombre:"Pan de queso, horneado",proteina:10.4,carbohidrato:31.4,lipids:20.8,calorias:367, semaforo: "3", file: "assets/PLATO"),
  Alimentos(id:5874,grupo:"11",nombre:"Café soluble descafeinado en polvo",proteina:11.6,carbohidrato:80.7,lipids:0.2,calorias:371, semaforo: "3", file: "assets/PLATO"),
  Alimentos(id:204,grupo:"1",nombre:"Galletas dulces con relleno",proteina:3.8,carbohidrato:68.6,lipids:24.1,calorias:516, semaforo: "1", file: "assets/PLATO"),
  Alimentos(id:224,grupo:"1",nombre:"Galletas dulces de avena con uvas pasas",proteina:6.5,carbohidrato:66.1,lipids:16.2,calorias:451, semaforo: "1", file: "assets/PLATO"),
  Alimentos(id:6074,grupo:"14",nombre:"Yogurt bebible semidescremado con azucar",proteina:4,carbohidrato:17.8,lipids:1.1,calorias:99, semaforo: "1", file: "assets/PLATO"),
 ];

 List<Tipo> tipoSolido=[
   Tipo(name: "gr", vInicial: 100, vConversion: 1),
   Tipo(name: "onzas", vInicial: 1, vConversion: 29.57),
    ];
 List<Tipo> tipoLiquido=[
   Tipo(name: "ml", vInicial:100, vConversion: 1),
   Tipo(name: "onzas", vInicial:1, vConversion: 29.57),
   Tipo(name: "tazas", vInicial:1, vConversion: 250),
   Tipo(name: "cuchara", vInicial:1, vConversion: 15),

 ];
 final cantidadControl = TextEditingController(text:"100");
 int _caloriasQue=0;
 int _caloriasCon=0;
 int _indexBottom = 0;
 String _tituloG="";
 double _valorConversion=100;
 int _valorInicGarga=100;
 double valorTextEdit=100;

 //GETTER
 String get tituloG => _tituloG;
 int get indexBottom => _indexBottom;
 int get caloriasQue => _caloriasQue;
 int get caloriasCon => _caloriasCon;
 double get valorConversion => _valorConversion;
 int get valorInicGarga => _valorInicGarga;
 List <Alimentos> get cenasList=> cenasLista;
 List <Alimentos> get almuerzosList=> almuerosLista;
 List <Alimentos> get meriendasList=> meriendasLista;
 List <Alimentos> get desayunosList=> desayunosLista;
 List <AlimentosDia> get almLisDia=> almLisDay;
 List <AlimentosDia> get cenLisDia=> cenLisDay;
 List <AlimentosDia> get merLisDia=> merLisDay;
 List <AlimentosDia> get desLisDia=> desLisDay;
 List <Medidas> get medidasEvaluar=> medidasFisicas;

 //SETTER
 set indexBottom(value) {
    _indexBottom = value;
    notifyListeners();
 }
 set caloriasCon(value) {
    _caloriasCon = value;
    notifyListeners();
 }
 set caloriasQue(value) {
    _caloriasQue = value;
    notifyListeners();
 }
 set tituloG(value) {
    _tituloG= value;
 }
 set valorInicGarga(value) {
    _valorInicGarga= value;
 }
 set valorConversion(value) {
    _valorConversion= value;
 }

 
 void notiCambios(){
  notifyListeners();
 }
  void clearVectores(){
 alimentosDay.clear();
  almLisDay.clear();   
  cenLisDay.clear();
  merLisDay.clear();
  desLisDay.clear();
 }
 void borrarAlimento(int index, bool redibujar){
   switch (_tituloG) {
    case 'Almuerzo':
        almuerosLista.removeAt(index);
        break;
      case 'Cena': 
         cenasLista.removeAt(index);
        break;
      case 'Desayuno': 
         desayunosLista.removeAt(index);
        break;
      case 'Meriendas': 
         meriendasLista.removeAt(index);  
        break;
   }


  if(redibujar) {
    notifyListeners();
  }
 }

}