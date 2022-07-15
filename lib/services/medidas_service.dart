
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutri_saludapp/models/models.dart';

class MedidasService extends ChangeNotifier{

   final String _baseUrl ='nutricontrol.co';
  
   
   Future<String?> insertarMedidas (List<ModelosSubirm> dataM) async{


    final url = Uri.https(_baseUrl, '/api/queries/Medidas');
    
    final valor =jsonEncode(dataM);
    final resp = await http.post(url , headers: {"Content-Type": "application/json"} ,body: valor);
    final Map <String , dynamic> decodeResp = jsonDecode(resp.body); 
       if(decodeResp.containsKey('success')) 
         { 
          if(decodeResp['success']==1){
            return "registro exitoso";
           }
         else
           {
           return "no se pudo registrar";
          }
        }
       else{
         return "Servidor no responde";
         }
   
   }
   Future < List<Medidas>> searchMedidas () async {
    
    const base='api/queries/Medidas';
    final url= Uri.https(_baseUrl,base);
    final resp = await http.get(url);
    final searchMedidas= MedidasCargar.fromJson(resp.body);
    return searchMedidas.data;
  }
  Future < List<MedidasTipo>> historialMedidas (String query) async {
    
    const base='api/queries/MedidasPresion';
    final url= Uri.https(_baseUrl,base);
    final resp = await http.get(url);
    final searchMedidas= ListaMedidas.fromJson(resp.body);
    return searchMedidas.data;
  }


}