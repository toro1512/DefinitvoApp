

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutri_saludapp/helpers/debouncer.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:http/http.dart' as http;

class FisicasService extends ChangeNotifier{
  final String _baseUrl ='nutricontrol.co';

  final debouncer= Debouncer(
    duration: const Duration(milliseconds: 500),
    );
  final StreamController <List <ActividadesFisicas>> _suggestionStreamController= StreamController.broadcast();
  Stream<List<ActividadesFisicas>> get suggestionsStream => _suggestionStreamController.stream;

   FisicasService();
 
  void getSuggestionByQuery(String query){

    debouncer.value ='';
    debouncer.onValue= (value) async {
      final result= await searchActividades();
      _suggestionStreamController.add(result);

    };
      final timer= Timer.periodic(const Duration(milliseconds: 200), (_) {
        debouncer.value=query;
       });
    
     Future.delayed(const Duration(milliseconds: 201)).then( (_) => timer.cancel());
  }

   Future < List<ActividadesFisicas>> searchActividades () async {
    
    const base='api/queries/ActividadesLike';
    final url= Uri.https(_baseUrl,base);
    final resp = await http.get(url);
    final searchActividades= SearchActividades.fromJson(resp.body);
    return searchActividades.data; 
  }
  Future <ValoresHistoria> caloriasConsu (String idU) async {
    
    final ValoresHistoria consumida;
    final base='api/queries/ActividadesCon/'+idU;
    final url= Uri.https(_baseUrl,base);
    final resp = await http.get(url);
    
    consumida=ValoresHistoria.fromJson(resp.body);
    return consumida; 
  }
  Future <ValoresHistoria> caloriasQuema(String idU) async {
    
    final ValoresHistoria consumida;
    final base='api/queries/ActividadesQue/'+idU;
    final url= Uri.https(_baseUrl,base);
    final resp = await http.get(url);
    
    consumida=ValoresHistoria.fromJson(resp.body);
    return consumida; 
  }
   Future < List<ActividadesFisicasC>> dayActividades (String query) async {
    
    final base='api/queries/ActividadesDay/'+query;
    final url= Uri.https(_baseUrl,base);
    final resp = await http.get(url);
    final searchActividades= ListaFisica.fromJson(resp.body);
    return searchActividades.data; 
  }

  Future<String?> insertarFisicas (List<ModelosSubirf> dataM) async{


    final url = Uri.https(_baseUrl, '/api/queries/Activities');
    
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

}