import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutri_saludapp/helpers/debouncer.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:http/http.dart' as http;

class AlimentosService extends ChangeNotifier {

  final String _baseUrl ='nutricontrol.co';
  
  final debouncer= Debouncer(
    duration: const Duration(milliseconds: 500),
    );
  final StreamController <List <Alimentos>> _suggestionStreamController= StreamController.broadcast();
  Stream<List<Alimentos>> get suggestionsStream => _suggestionStreamController.stream;
  
  
  AlimentosService();
  
   
  Future < List<Alimentos>> searchAlimentos (String query) async {
    
    final base='api/queries/FoodLike/'+query;
    final url= Uri.https(_baseUrl,base);
    final resp = await http.get(url);
    final searchAlimentos= SearchAlimentos.fromJson(resp.body);
    return searchAlimentos.data; 
  }
  Future<String?> insertarComidas (List<ModelosSubirc> alimentosSubir) async{


    final url = Uri.https(_baseUrl, '/api/queries/Food');
    
    final valor =jsonEncode(alimentosSubir);
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

  
  void getSuggestionByQuery(String query){

    debouncer.value ='';
    debouncer.onValue= (value) async {
      final result= await searchAlimentos(query);
      _suggestionStreamController.add(result);

    };
      final timer= Timer.periodic(const Duration(milliseconds: 200), (_) {
        debouncer.value=query;
       });
    
     Future.delayed(const Duration(milliseconds: 201)).then( (_) => timer.cancel());
  }


}