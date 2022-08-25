import 'package:flutter/material.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:charts_flutter/flutter.dart' as charts;
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
 List <ModelosSubirm> medidasSubir=[];
 List <MedidasTipo> medidasHistico=[];
 List<Expenses> data=[];
 List<Expenses> data2=[];
 List<ExpensesGli> dataGlu=[];
 List<Calorias> dataGrafiPri =[];
 


 
  List <Alimentos> almuerosSuge= [
  Alimentos(id:758,grupo:"5",nombre:"Cerdo lomo horneado sin sal",proteina:35.1,carbohidrato:0,lipids:3.2,calorias:170, semaforo: "2", file: "assets/CARNES", amount: 100),
  Alimentos(id:852,grupo:"5",nombre:"Res lomo cocido sin sal",proteina:36.1,carbohidrato:0,lipids:7.9,calorias:218, semaforo: "2", file: "assets/CARNES", amount: 100),
  Alimentos(id:390,grupo:"6",nombre:"Arroz blanco pulido cocido sin sal",proteina:2.3,carbohidrato:30.9,lipids:2.1,calorias:161, semaforo:"2", file: "assets/CEREALES", amount: 100),
  Alimentos(id:452,grupo:"6",nombre:"Pasta alimenticia con huevo sin enriquecer cocida sin sal",proteina:4.5,carbohidrato:24.3,lipids:1,calorias:132, semaforo: "2", file: "assets/CEREALES", amount: 100),
  Alimentos(id:576,grupo:"16",nombre:"Yuca blanca sin cáscara cocida sin sal ",proteina:0.7,carbohidrato:33.9,lipids:0.2,calorias:157, semaforo: "1", file: "assets/VERDURAS", amount: 100),
  Alimentos(id:1050,grupo:"1",nombre:"Jute de papa criolla",proteina:2.3,carbohidrato:0,lipids:0,calorias:123, semaforo: "2", file: "assets/VERDURAS", amount: 100),
 ];
 List <Alimentos> desayunosSuge= [
   Alimentos(id:923,grupo:"10" ,nombre: "Huevo de gallina entero revuelto con sal", proteina: 10.2, carbohidrato: 0,lipids: 11.4, calorias: 152, semaforo: "1", file: "assets/LACTEOS" , amount: 100),
   Alimentos(id:922,grupo: "10" ,nombre: "Huevo de gallina entero frito sin sal", proteina: 17.1, carbohidrato: 0,lipids: 14.6, calorias: 208, semaforo: "1", file: "assets/LACTEOS" , amount: 100),
   Alimentos(id:396,grupo:"6",nombre:"Cereal para el desayuno hojuelas de maíz sin azúcar",proteina:8.1,carbohidrato:81.7,lipids:0.4,calorias:383, semaforo: "2", file: "assets/CEREALES", amount: 100),
   Alimentos(id:441,grupo:"6",nombre:"Pan blanco regular horneado",proteina:8.9,carbohidrato:45.6,lipids:3.4,calorias:268, semaforo: "2", file: "assets/CEREALES", amount: 100),
   Alimentos(id:385,grupo:"6",nombre:"Arepa de maíz precocido con sal ",proteina:3.3,carbohidrato:34.1,lipids:0.9,calorias:163, semaforo: "2", file: "assets/CEREALES", amount: 100),
   Alimentos(id:388,grupo:"6",nombre:"Arepa de maíz con queso asada",proteina:4.8,carbohidrato:0,lipids:8.4,calorias:211, semaforo: "2", file: "assets/CEREALES", amount: 100),
   Alimentos(id:389,grupo:"6",nombre:"Arepa de maíz frita ",proteina:3.4,carbohidrato:0,lipids:20.3,calorias:325, semaforo: "2", file: "assets/CEREALES", amount: 100)
 ];
 List <Alimentos> cenasSuge= [
   Alimentos(id:388,grupo:"6",nombre:"Arepa de maíz con queso asada",proteina:4.8,carbohidrato:0,lipids:8.4,calorias:211, semaforo: "2", file: "assets/CEREALES", amount: 100),
   Alimentos(id:389,grupo:"6",nombre:"Arepa de maíz frita ",proteina:3.4,carbohidrato:0,lipids:20.3,calorias:325, semaforo: "2", file: "assets/CEREALES", amount: 100),
   Alimentos(id:885,grupo:"9",nombre:"Queso fresco blando magro tipo suero costeño",proteina:11,carbohidrato:0,lipids:1.5,calorias:83, semaforo: "2", file: "assets/LIQUIDO", amount: 100),
   Alimentos(id:888,grupo:"9",nombre:"Queso fresco semiduro semigraso tipo costeño",proteina:17.5,carbohidrato:0,lipids:25.5,calorias:303, semaforo: "2", file: "assets/LIQUIDO", amount: 100),
   Alimentos(id:987,grupo:"3",nombre:"Yogurt bebible descremado sin azucar",proteina:3.7,carbohidrato:7.9,lipids:0.3,calorias:49, semaforo: "2", file: "assets/PLATO", amount: 100),
   Alimentos(id:393,grupo:"6",nombre:"Avena en hojuelas precocida",proteina:16.9,carbohidrato:54.3,lipids:7.5,calorias:411, semaforo: "2", file: "assets/CEREALES", amount: 100),
 ];
 List <Alimentos> meriendasSuge= [
  Alimentos(id:397, grupo:"6", nombre:"croissant de queso horneado", proteina:9.2, carbohidrato:46.3, lipids:23, calorias:445, semaforo: "2", file: "assets/CEREALES", amount: 100),
  Alimentos(id:446,grupo:"6",nombre:"Pan de queso horneado",proteina:10.4,carbohidrato:31.4,lipids:20.8,calorias:367, semaforo: "2", file: "assets/CEREALES", amount: 100),
  Alimentos(id:968,grupo:"13",nombre:"Café soluble descafeinado en polvo",proteina:11.6,carbohidrato:80.7,lipids:0.2,calorias:371, semaforo: "3", file: "assets/MISCELANEOS", amount: 100),
  Alimentos(id:401,grupo:"6",nombre:"Galletas dulces con relleno",proteina:3.8,carbohidrato:68.6,lipids:24.1,calorias:516, semaforo: "2", file: "assets/CEREALES", amount: 100),
  Alimentos(id:403,grupo:"6",nombre:"Galletas dulces de avena con uvas pasas",proteina:6.5,carbohidrato:66.1,lipids:16.2,calorias:451, semaforo: "2", file: "assets/CEREALES", amount: 100),
  Alimentos(id:988,grupo:"3",nombre:"Yogurt bebible semidescremado con azucar",proteina:4,carbohidrato:17.8,lipids:1.1,calorias:99, semaforo: "2", file: "assets/PLATO", amount: 100),
 ];

 List<Tipo> tipoSolido=[
   Tipo(name: "gr", vInicial: 100, vConversion: 0.001),
   Tipo(name: "onzas", vInicial: 1, vConversion: 0.0030),
   Tipo(name: "libra", vInicial: 1, vConversion: 4.54),
    ];
 List<Tipo> tipoLiquido=[
   Tipo(name: "ml", vInicial:100, vConversion: 0.001),
   Tipo(name: "tazas", vInicial:1, vConversion: 2.5),
   Tipo(name: "cuchara", vInicial:1, vConversion: 0.0015),

 ];
 final cantidadControl = TextEditingController(text:"100");
 final tensionAlta = TextEditingController();
 final tensionBaja = TextEditingController();
 final axucarContr = TextEditingController();
 bool _antesComer=false;
 double _caloriasQue=0;
 double _caloriasCon=0;
 int _indexBottom = 0;
 String _tituloG="";
 String _fechaC="";
 String _fechaF="";
 String _fechaM="";
 double _valorConversion=0.01;
 int _valorInicGarga=100;
 double valorTextEdit=100;
 int _idUsuario=-1;

 //GETTER
 String get tituloG => _tituloG;
 String get fechaC => _fechaC;
 String get fechaM => _fechaM;
 String get fechaF => _fechaF;
 bool get antesComer => _antesComer;
 int get indexBottom => _indexBottom;
 int get idUsuario => _idUsuario;
 double get caloriasQue => _caloriasQue;
 double get caloriasCon => _caloriasCon;
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
 set antesComer(value) {
    _antesComer = value;
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
 set fechaC(value) {
    _fechaC= value;
 }
 set fechaM(value) {
    _fechaM= value;
 }
 set fechaF(value) {
    _fechaF= value;
 }
 set valorInicGarga(value) {
    _valorInicGarga= value;
 }
 set valorConversion(value) {
    _valorConversion= value;
 }
 set idUsuario(value) {
    _idUsuario= value;
 }

 
 void notiCambios(){
  notifyListeners();
 }
 void llenarGraficas(){
       data.clear();
       data2.clear();
       for(int i=0; i<medidasHistico.length; i++){
        data.add(objetoExp(medidasHistico[i].measureDate.substring(5, 10),medidasHistico[i].measureTime.substring(0, 8),medidasHistico[i].valor));
        data2.add(objetoExp(medidasHistico[i].measureDate.substring(5, 10),medidasHistico[i].measureTime.substring(0, 8),medidasHistico[i].valueAlt));
      }
 }
 void llenarGraficasCircular(double queCalo, double conCalo){
       dataGrafiPri.clear();
       dataGrafiPri =[
      Calorias('Quemadas',queCalo, Colors.lightGreen),
      Calorias('Consumidas',conCalo, const Color.fromRGBO(234, 24, 77, 1)),
        ];
        notifyListeners();
      
 }
 void llenarGraficasGlu(){
  Color colorB;
       dataGlu.clear();
       
       for(int i=0; i<medidasHistico.length; i++){
        if(medidasHistico[i].beforeAfter=='1')
        { colorB=Colors.grey;
          dataGlu.add(objetoExpGlu(medidasHistico[i].measureDate.substring(5, 10),medidasHistico[i].measureTime,medidasHistico[i].valor,colorB)); }
        else
        { colorB=Colors.green;
          dataGlu.add(objetoExpGlu(medidasHistico[i].measureDate.substring(5, 10),medidasHistico[i].measureTime,medidasHistico[i].valor,colorB));}
      }
 }
 Expenses objetoExp(String day, String hora, int medida){
   
    Expenses _objet= Expenses('$day / $hora', medida);
    return _objet;
 }
 ExpensesGli objetoExpGlu(String day, String hora, int medida, Color color){
   
    ExpensesGli _objet= ExpensesGli('$day / $hora', medida,charts.ColorUtil.fromDartColor(color));
    return _objet;
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