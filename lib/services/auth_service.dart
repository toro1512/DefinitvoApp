import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/share_preferences/preferences.dart';

class AuthService extends ChangeNotifier{

final String _baseUrl ='nutricontrol.co';
final storage = const FlutterSecureStorage();

  Future<String?> createrLogin (String email, String password) async{

    final Map<String, dynamic> regiData={
        "email": email,
        "password": password,
        "role": 1
    };
    final url = Uri.https(_baseUrl,'/api/login');  
     
    final resp = await http.post(url , headers: {"Content-Type": "application/json"} ,body: json.encode(regiData)); 
    final Map <String , dynamic> decodeResp = jsonDecode(resp.body);
    if(decodeResp.containsKey('success')) 
    {
      if(decodeResp['success']==1){
         
          return "registro exitoso";

      }
      else{
        return "no se pudo registrar";
      }

    }
    else{
        return "Servidor no responde";
    }

    
   }


 Future<String?> login (String email, String password) async{

    final Map<String, dynamic> authData={
        "email": email,
        "password": password,
    };
    final url = Uri.https(_baseUrl, '/api/login/login');
    
    final resp = await http.post(url , headers: {"Content-Type": "application/json"} ,body: json.encode(authData)); 
    final Map <String , dynamic> decodeResp = jsonDecode(resp.body); 
    if(decodeResp.containsKey('token')) {
      await storage.write(key: 'inicio', value: "Creado");
      await storage.write(key: 'tokenm', value: decodeResp['token']);
      await storage.write(key: 'usuario', value: email);
      Preferences.idUs=decodeResp['id'];
      await storage.write(key: 'idd', value: decodeResp['id'].toString());
      if(Preferences.pesoUs!=-1){
         DateTime now = DateTime.now();
         String _dateMn = DateFormat('kk:mm:ss').format(now);
         String _fechaMn = DateFormat('yyyy-MM-dd').format(now);
         final urlM = Uri.https(_baseUrl, '/api/queries/Medidas');
          List <ModelosSubirm> auxSubirFsica=[
           ModelosSubirm(idUsers: Preferences.idUs, idPhysicalMeasures: 2, beforeAfter: 1, value: Preferences.pesoUs, measureDate: _fechaMn, measureTime: _dateMn, valueAlt:0),
           ModelosSubirm(idUsers: Preferences.idUs, idPhysicalMeasures: 3, beforeAfter: 1, value: Preferences.altuUs, measureDate: _fechaMn, measureTime: _dateMn, valueAlt: 0), 
          ];
         final valor =jsonEncode(auxSubirFsica);
         final respond = await http.post(urlM , headers: {"Content-Type": "application/json"} ,body: valor);
         final Map <String , dynamic> decodeRespuee = jsonDecode(respond.body); 
         if(decodeRespuee.containsKey('success')) 
            { 
             if(decodeRespuee['success']==1){
                 
             }
           else
             {
             
             }
        }
      }
      if(Preferences.pesoUs==-1){
         final baseAc='api/queries/MedidasPeso/'+decodeResp['id'].toString()+'/'+'2';
         final urlAc= Uri.https(_baseUrl,baseAc);
         final respu = await http.get(urlAc);
         final Map <String , dynamic> decodeRespu = jsonDecode(respu.body);
         if(decodeRespu.containsKey('value')){
          
            Preferences.pesoUs=decodeRespu['value']+0.0;
         }
        
      }  
    }
    else{
      return decodeResp['message'];}
   }
Future<String?> createUsuario (String email, String nombre, DateTime fecha, String sexo) async{
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String strfecha = formatter.format(fecha);
    final Map<String, dynamic> userData={
        "email": email,
        "nombre": nombre,
        "fecha": strfecha,
        "sexo": sexo,
        "nacionalidad": "C"
    };
    final url = Uri.https(_baseUrl, '/api/user');
    
    final resp = await http.post(url , headers: {"Content-Type": "application/json"} ,body: json.encode(userData)); 
   final Map <String , dynamic> decodeResp = jsonDecode(resp.body); 
   if(decodeResp.containsKey('success')) 
    {
      if(decodeResp['success']==1){
         return "registro exitoso";

       }
      else{
        return "no se pudo registrar";
      }

    }
    else{
        return "Servidor no responde";
    }

   
   }   
   
Future logout() async{
 
  await storage.delete(key: 'tokenm');
  await storage.delete(key: 'idd');
  Preferences.idUs=-1;
  Preferences.pesoUs=-1;
 
 }
Future<String> readToken() async {
String val=await storage.read(key: 'tokenm') ?? '';
return val; 
}
Future<String> readId() async {
String val=await storage.read(key: 'idd') ?? '';
return val; 
}
Future<String> readInicio() async {
String val=await storage.read(key: 'inicio') ?? '';
if(val==''){
  return val; 
}
val='';
val=await storage.read(key: 'tokenm') ?? '';
 if(val=='')
 {
return "vacio";
 }
 else {
  return val;
 }
}

}