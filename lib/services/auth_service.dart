import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final url = Uri.https(_baseUrl, '/api/login');  
     
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