import 'package:flutter/material.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:http/http.dart' as http;



class AlimentosDayService extends ChangeNotifier{

   final String _baseUrl ='nutricontrol.co';


   Future < List<AlimentosDia>> searchAlimentos (String query) async {
    
    final base='api/queries/FoodDay/'+query;
    final url= Uri.https(_baseUrl,base);
    final resp = await http.get(url);
    final searchAlimentos= ListaAlimentos.fromJson(resp.body);
    return searchAlimentos.data; 
  }
  
   Future < List<ActividadesFisicas>> searchActividades () async {
    
    const base='api/queries/ActividadesLike';
    final url= Uri.https(_baseUrl,base);
    final resp = await http.get(url);
    final searchActividades= SearchActividades.fromJson(resp.body);
    return searchActividades.data; 
  }
  
}