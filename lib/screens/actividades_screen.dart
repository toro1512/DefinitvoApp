import 'package:flutter/material.dart';
import 'package:nutri_saludapp/search/search_delegate.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';

class ActividadesScreen extends StatelessWidget {
  const ActividadesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final String _titulo = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        title: Text(_titulo, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body:SingleChildScrollView(child: 
              Column(
               children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextField(
                     readOnly: true,
                     style: const TextStyle(fontSize: 14),
                     onTap: () {
                        showSearch(context: context, delegate: ActividadesSearchDelegate(titulo: _titulo));
                       },
                     decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.all(4), 
                      hintText: 'Buscar Actividad',
                      border: const OutlineInputBorder(),
                      prefixIcon: IconButton(icon: const Icon(Icons.search_rounded) ,
                       onPressed: () => showSearch(context: context, delegate: ActividadesSearchDelegate(titulo: _titulo)),
                        )
                    ),
              
                  ),
                 ),
                 ]
                 )
                 ),
    );
  }
}