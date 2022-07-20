import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/services/services.dart';
import 'package:provider/provider.dart';

class AlimentosSearchDelegate extends SearchDelegate{

  final String titulo;

  AlimentosSearchDelegate({
    required this.titulo
  });
  

  @override
  
  String? get searchFieldLabel => 'Buscar Alimentos';


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
    IconButton(
      onPressed: ()=> query ='',
      icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: (){
        
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('');
  }

  Widget _emptyContainer(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset('assets/NUTRISALUD-NS.svg',),
      ),
    );
  }
  Widget _noRespContainer(){
    return Column(
      children: const [
        SizedBox(height: 30),
        Center(child: Text ('No Tenemos Coincidencia', style: TextStyle (color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold))),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty) {
      return _emptyContainer();
    }
   final alimentosService = Provider.of<AlimentosService>(context, listen: false ); 
   alimentosService.getSuggestionByQuery(query);
    
   return StreamBuilder(
     stream: alimentosService.suggestionsStream,
     builder: ( _ , AsyncSnapshot<List<Alimentos>> snapshot ){
         
        if (!snapshot.hasData) return _emptyContainer(); 
        final alimentos= snapshot.data!;
        if(alimentos.isEmpty) return _noRespContainer(); 
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: alimentos.length,
          itemBuilder: ( _ , int index  ) =>  _AlimentosSugeridos(alimento: alimentos[index] ));

     });  

  }
  
}

class _AlimentosSugeridos extends StatelessWidget {

   final Alimentos alimento;
 
  const _AlimentosSugeridos({
    Key? key, 
    required this.alimento,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     String rutaFile="";
   switch (alimento.semaforo) {
       case "1":
          rutaFile=alimento.file+' A.svg';
         break;
       case "2":
         rutaFile=alimento.file+' B.svg';
        break;
       case "3":
          rutaFile=alimento.file+' C.svg';
         break;   
     }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(0), color: Colors.grey[200]),
            child: ListTile(
               onTap: () => Navigator.pushNamed(context, 'detalleAli', arguments: alimento),
              contentPadding:const EdgeInsets.only(left: 5,right: 2,top: 2,bottom: 2),
              dense: true,
              
              title: Text(alimento.nombre, style: const TextStyle( fontSize: 14)),
              subtitle: Text('cal: '+alimento.calorias.toString()+'; pro: '+alimento.proteina.toString() +'; car: '+alimento.carbohidrato.toString()+'; lips: '+alimento.lipids.toString() , style: const TextStyle(fontSize: 10)),
              leading: SvgPicture.asset(rutaFile,height: 40, width: 40,),
            ),
          ),
    );
  }
} 
class ActividadesSearchDelegate extends SearchDelegate{

  final String titulo;

  ActividadesSearchDelegate({
    required this.titulo
  });
  

  @override
  
  String? get searchFieldLabel => 'Buscar Actividades';


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
    IconButton(
      onPressed: ()=> query ='',
      icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: (){
        
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('');
  }

  Widget _emptyContainer(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset('assets/NUTRISALUD-NS.svg',),
      ),
    );
  }
  Widget _noRespContainer(){
    return Column(
      children: const [
        SizedBox(height: 30),
        Center(child: Text ('No Tenemos Coincidencia', style: TextStyle (color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold))),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty) {
      return _emptyContainer();
    }
   final alimentosService = Provider.of<AlimentosService>(context, listen: false ); 
   alimentosService.getSuggestionByQuery(query);
    
   return StreamBuilder(
     stream: alimentosService.suggestionsStream,
     builder: ( _ , AsyncSnapshot<List<Alimentos>> snapshot ){
         
        if (!snapshot.hasData) return _emptyContainer(); 
        final alimentos= snapshot.data!;
        if(alimentos.isEmpty) return _noRespContainer(); 
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: alimentos.length,
          itemBuilder: ( _ , int index  ) =>  _ActividadesSugeridos(alimento: alimentos[index] ));

     });  

  }
  
}

class _ActividadesSugeridos extends StatelessWidget {

   final Alimentos alimento;
 
  const _ActividadesSugeridos({
    Key? key, 
    required this.alimento,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     String rutaFile="";
   switch (alimento.semaforo) {
       case "1":
          rutaFile=alimento.file+' A.svg';
         break;
       case "2":
         rutaFile=alimento.file+' B.svg';
        break;
       case "3":
          rutaFile=alimento.file+' C.svg';
         break;   
     }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(0), color: Colors.grey[200]),
            child: ListTile(
               onTap: () => Navigator.pushNamed(context, 'detalleAli', arguments: alimento),
              contentPadding:const EdgeInsets.only(left: 5,right: 2,top: 2,bottom: 2),
              dense: true,
              
              title: Text(alimento.nombre, style: const TextStyle( fontSize: 14)),
              subtitle: Text('cal: '+alimento.calorias.toString()+'; pro: '+alimento.proteina.toString() +'; car: '+alimento.carbohidrato.toString()+'; lips: '+alimento.lipids.toString() , style: const TextStyle(fontSize: 10)),
              leading: SvgPicture.asset(rutaFile,height: 40, width: 40,),
            ),
          ),
    );
  }
}   

