import 'package:flutter/material.dart';
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
    return const Center(
      child: Icon(Icons.launch_sharp, size: 150, color: Colors.black38),
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
      Color color=Colors.white;
     switch (alimento.semaforo) {
       case 1:
         color=Colors.green.shade200;
         break;
        case 2:
         color=Colors.yellow.shade200;
         break;
         case 3:
         color=Colors.red.shade200;
         break;   
      
     }
    return  Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                
                tileColor:color,
              //  title: CustomItemAlimentos(alimento: alimento),

                onTap: () => Navigator.pushNamed(context, 'detalleAli', arguments: alimento),
                
      )
    );
  }
}    