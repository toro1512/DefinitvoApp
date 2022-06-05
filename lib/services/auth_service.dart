import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';


class AuthService extends ChangeNotifier{

final String _baseUrl ='nutricontrol.co';
final storage = const FlutterSecureStorage();




  Future<String?> createrUser (String email, String password) async{

    final Map<String, dynamic> authData={
        "email": email,
        "password": password,
    };
    final url = Uri.https(_baseUrl, '/api/usuarios/login');
    
    final resp = await http.post(url , headers: {"Content-Type": "application/json"} ,body: json.encode(authData)); 
    final Map <String , dynamic> decodeResp = jsonDecode(resp.body); 
    if(decodeResp.containsKey('token')) {
      await storage.write(key: 'tokenm', value: decodeResp['token']);
    }
    else{
      return decodeResp['message'];}
   }


 Future<String?> login (String email, String password) async{

    final Map<String, dynamic> authData={
        "email": email,
        "password": password,
    };
    final url = Uri.https(_baseUrl, '/api/usuarios/login');
    
    final resp = await http.post(url , headers: {"Content-Type": "application/json"} ,body: json.encode(authData)); 
    final Map <String , dynamic> decodeResp = jsonDecode(resp.body); 
    if(decodeResp.containsKey('token')) {
      await storage.write(key: 'tokenm', value: decodeResp['token']);
    }
    else{
      return decodeResp['message'];}
   }
   
 Future logout() async{
 
  await storage.delete(key: 'tokenm');
 
 }
Future<String> readToken() async {

return await storage.read(key: 'tokenm') ?? ''; 

}

}