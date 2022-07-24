import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/search/search_delegate.dart';
import 'package:nutri_saludapp/services/services.dart';
import 'package:nutri_saludapp/share_preferences/preferences.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:provider/provider.dart';

class AlimentosScreen extends StatelessWidget {

  const AlimentosScreen({ Key? key }) : super(key: key);

@override
  Widget build(BuildContext context) {
   
    List<Alimentos> aux=[];
    List<Alimentos> auxSuger=[]; 
    List<ModelosSubirc> cargaComida =[];

    final generalProvider = Provider.of<GeneralProvider>(context);
    final alimentosService= Provider.of<AlimentosService>(context);
    int _idComida=0;  
    final String _titulo = ModalRoute.of(context)!.settings.arguments as String;
    generalProvider.tituloG=_titulo;
      

      switch( _titulo ) {

      case 'Almuerzo':
        aux=generalProvider.almuerosLista;
        auxSuger=generalProvider.almuerosSuge;
        _idComida=2;
        break;
      case 'Cena': 
          aux=generalProvider.cenasLista;
          auxSuger=generalProvider.cenasSuge;
          _idComida=3;
        break;
      case 'Desayuno': 
          aux=generalProvider.desayunosLista;
          auxSuger=generalProvider.desayunosSuge;
          _idComida=1;
        break;
      case 'Merienda': 
          aux=generalProvider.meriendasLista;
          auxSuger=generalProvider.meriendasSuge;
          _idComida=4;
        break;
   
    }
      int mostrar=aux.length;
      return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        title: Text(_titulo, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        actions: [      
          Container(
             padding: const EdgeInsets.all(15),
             decoration: const BoxDecoration(shape: BoxShape.circle,color:Colors.lightGreen),
             margin:const  EdgeInsets.symmetric(horizontal: 15),
             child: Center(child: Text('$mostrar', style: const TextStyle(color: Colors.white),)),
         )
        ],
      ),
      body: SingleChildScrollView(child: 
         Column( children: [
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
               readOnly: true,
               style: const TextStyle(fontSize: 14),
               onTap: () {

                 showSearch(context: context, delegate: AlimentosSearchDelegate(titulo: _titulo));
              
              },
               decoration: InputDecoration(
                 isDense: true,
                 contentPadding: const EdgeInsets.all(4), 
                 hintText: 'Buscar Alimentos',
                 border: const OutlineInputBorder(),
                 prefixIcon: IconButton(icon: const Icon(Icons.search_rounded) ,
                  onPressed: () => showSearch(context: context, delegate: AlimentosSearchDelegate(titulo: _titulo)),
                   )
               ),
              
             ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                child: Column(
                      children:[
                        if(aux.isNotEmpty) ...[
                        const  SizedBox(height: 10),
                         Text('Tu '+_titulo+' es:', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black) ),
                         Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          child: SizedBox(
                            height: 220,
                            child: ListView.builder(
                               itemCount: aux.length,
                               shrinkWrap: true,
                               
                               itemBuilder: (_, index) =>
                               _CuerpoListBuil(aux: aux, index:index, generalProvider: generalProvider), 
                               
                            ),
                          ),
                         ),
                        ]
                        else ...[
                        
                        Container(
                          height: 220,
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                          child: 
                          const Center(
                            child: 
                            Text('Lista de Alimentos a Cargar', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),))),
                        

                        ] 
                      ]

                )
              ),
            ),
             if(aux.isNotEmpty)
             ElevatedButton.icon(
               style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)),
               icon: const Icon(Icons.save), label: const Text('Guardar', style: TextStyle(fontSize: 16)),
               onPressed: () async{
              
                  llenarEnvio(cargaComida,aux, generalProvider,_idComida);
                  final String? respuesta=await alimentosService.insertarComidas(cargaComida);
                      if(respuesta=="registro exitoso"){
                         cargaComida.clear();
                         aux.clear();
                         ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(duration: const Duration(seconds: 2),
                          content: Text(_titulo+" Cargado")));
                         generalProvider.notiCambios();
                        }

               },
               ),
               
                const Text('Sugerencias',style: TextStyle(
                   fontSize: 18,)),
                          
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: 
              ListView.builder(
                
              itemCount: auxSuger.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) => _CuerpoSugerencias(index:index, auxSuger: auxSuger, aux: aux, generalProvider: generalProvider),
            ),
               ),

         ],
           

         )
      ),
    
    );
   
     
  }

  void llenarEnvio(List<ModelosSubirc> cargaComida, List<Alimentos> aux, GeneralProvider generalProvider, int idComida) {

      for(int i=0; i<aux.length;i++){
        ModelosSubirc _obj= ModelosSubirc (amount: aux[i].amount, idFood: aux[i].id, fecha: generalProvider.fechaC, idFoodMoment: idComida, idUser: Preferences.idUs);
        cargaComida.add(_obj);
        }
      


  }

}  

class _CuerpoSugerencias extends StatelessWidget {
  const _CuerpoSugerencias({
    Key? key,
    required this.auxSuger,
    required this.index,
    required this.aux,
    required this.generalProvider,
  }) : super(key: key);

  final List<Alimentos> auxSuger;
  final List<Alimentos> aux;
  final GeneralProvider generalProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
   
    String rutaIcon='assets/PLATO A.svg';
   
     switch (auxSuger[index].semaforo) {
       case "1":
         rutaIcon=auxSuger[index].file+' A.svg';
         break;
        case "2":
          rutaIcon=auxSuger[index].file+' B.svg';
         break;
         case "3":
          rutaIcon=auxSuger[index].file+' C.svg';
         break;   
     }
     return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        
        decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(0), color: Colors.grey[200]),
        child: ListTile(
          onTap: () => Navigator.pushNamed(context, 'detalleAli', arguments: auxSuger[index]),
          contentPadding: const EdgeInsets.only(left: 5,right: 2,top: 2,bottom: 2),
          dense: false,
          title:  Stack(
              children: <Widget>[
                Text(auxSuger[index].nombre,
                    style: const TextStyle(
                    fontSize: 14,
                   
                    ),
                ),
                
             ],
            ),  
          //Text(auxSuger[index].nombre,style: TextStyle(color: color),maxLines: 1,overflow: TextOverflow.ellipsis,  ),
          subtitle: Text('cal: '+auxSuger[index].calorias.toString()+'; pro: '+auxSuger[index].proteina.toString() +'; car: '+auxSuger[index].carbohidrato.toString()+'; lips: '+auxSuger[index].lipids.toString() , style: const TextStyle(fontSize: 10)),
          leading:SvgPicture.asset(rutaIcon,height: 40, width: 40,),
          trailing: IconButton( 
            padding: const EdgeInsets.only(right: 3),
            alignment: Alignment.centerRight,
            icon: const Icon(Icons.add_circle, color: AppTheme.primary,), onPressed: (){
              aux.add(auxSuger[index]);
              generalProvider.notiCambios();
            },),
        
        
        ),
      ),
    );
  }
}

class _CuerpoListBuil extends StatelessWidget {
  const _CuerpoListBuil({
    Key? key,
    required this.aux,
    required this.index,
    required this.generalProvider,
  }) : super(key: key);

  final List<Alimentos> aux;
  final int index;
  final GeneralProvider generalProvider;
 
  

  @override
  Widget build(BuildContext context) {
  
  String rutaFile="";
   switch (aux[index].semaforo) {
       case "1":
          rutaFile=aux[index].file+' A.svg';
         break;
       case "2":
         rutaFile=aux[index].file+' B.svg';
        break;
       case "3":
          rutaFile=aux[index].file+' C.svg';
         break;   
     }
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete_rounded),),
        onDismissed: (DismissDirection direction){
          generalProvider.borrarAlimento(index, true);        
        },
        child: Container(
           decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(0), color: Colors.grey[200]),
           child: ListTile(
             onTap: () => Navigator.pushNamed(context, 'detalleAli', arguments: aux[index]),
            contentPadding:const EdgeInsets.only(left: 5,right: 2,top: 2,bottom: 2),
            dense: true,
            title: Text(aux[index].nombre,style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis,),
            subtitle: Text('cal: '+aux[index].calorias.toString()+' grs: '+aux[index].lipids.toString()+' pro: '+aux[index].proteina.toString() +' car: '+aux[index].carbohidrato.toString() , style: const TextStyle(fontSize: 10)),
            leading: SvgPicture.asset(rutaFile,height: 40, width: 40,),
            trailing: IconButton( 
              padding: const EdgeInsets.only(right: 3),
            alignment: Alignment.centerRight,
            icon: const Icon(Icons.close_rounded, color: AppTheme.primary,), onPressed: (){
               generalProvider.borrarAlimento(index, true);
           },),
                    
                    
         ),
        ),
      ), 
    );
  }
}

