import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/search/search_delegate.dart';
import 'package:nutri_saludapp/services/services.dart';
import 'package:nutri_saludapp/share_preferences/preferences.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:provider/provider.dart';

class ActividadesScreen extends StatelessWidget {
  const ActividadesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ActividadesFisicas> auxSuger=[];
    List<ModelosSubirf> cargaFisica =[]; 

     final String _titulo = ModalRoute.of(context)!.settings.arguments as String;
     final actividadesProvider=Provider.of<ActividadesProvider>(context);
      final fisicasService=Provider.of<FisicasService>(context);
      switch( _titulo ) {

      case 'Deportivas':
         auxSuger=actividadesProvider.deportivasSug;
         break;
      case 'Ocupacionales': 
          
          auxSuger=actividadesProvider.ocupacionalesSug;
          
        break;
      case 'Recreacionales': 
          
          auxSuger=actividadesProvider.recreacionalesSug;
         
        break;
      
   
    }
      int mostrar=actividadesProvider.actividadesAlDia.length;
     
    
    return Scaffold(
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
      body:SingleChildScrollView(child: 
              Column(
               children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextField(
                     readOnly: true,
                     style: const TextStyle(fontSize: 14),
                     onTap: () {
                        showSearch(context: context, delegate: ActividadesSearchDelegate( todasAciti:actividadesProvider.todasActividades));
                       },
                     decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.all(4), 
                      hintText: 'Buscar Actividad',
                      border: const OutlineInputBorder(),
                      prefixIcon: IconButton(icon: const Icon(Icons.search_rounded) ,
                       onPressed: () =>{
                        showSearch(context: context, delegate: ActividadesSearchDelegate(todasAciti: actividadesProvider.todasActividades))
                       }
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
                        if(actividadesProvider.actividadesAlDia.isNotEmpty) ...[
                        const  SizedBox(height: 10),
                         const Text('Actividades a cargar:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black) ),
                         Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          child: SizedBox(
                            height: 220,
                            child: ListView.builder(
                               itemCount: actividadesProvider.actividadesAlDia.length,
                               shrinkWrap: true,
                               
                               itemBuilder: (_, index) =>
                               _CuerpoListBuil( index:index, actividadesProvider: actividadesProvider), 
                               
                            ),
                          ),
                         ),
                        ]
                        else ...[
                        
                        Container(),
                        

                        ] 
                      ]

                )
              ),
            ),
             if(actividadesProvider.actividadesAlDia.isNotEmpty)
             ElevatedButton.icon(
               style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)),
               icon: const Icon(Icons.save), label: const Text('Guardar', style: TextStyle(fontSize: 16)),
               onPressed: () async {
                llenarEnviofi(cargaFisica, actividadesProvider);
                final String? respuesta=await fisicasService.insertarFisicas(cargaFisica);
                      if(respuesta=="registro exitoso"){
                        cargaFisica.clear();
                        actividadesProvider.actividadesAlDia.clear();
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(duration: Duration(seconds: 2),
                          content: Text("Cargadas las actividades")));
                         actividadesProvider.notiCambiosac();
                      }
               } 
                /* onPressed: () async{
              
                llenarEnvio(cargaComida,aux, generalProvider,_idComida);
                  final String? respuesta=await alimentosService.insertarComidas(cargaComida);
                      if(respuesta=="registro exitoso"){
                         cargaComida.clear();
                        actividadesProvider.actividadesAlDia.clear();
                         ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(duration: const Duration(seconds: 2),
                          content: Text(_titulo+" Cargado")));
                         actividadesProvider.notiCambiosac();
                        }

               },*/
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
              itemBuilder: (_, index) => _CuerpoSugerencias(index:index, auxSuger: auxSuger, actividadesProvider: actividadesProvider),
            ),
               ),

 
                 ]
                 )
                 ),
    );
  }
}

void llenarEnviofi(List<ModelosSubirf> cargaFisica, ActividadesProvider actividadesProvider) {
   for(int i=0; i<actividadesProvider.actividadesAlDia.length;i++){
        ModelosSubirf _obj=ModelosSubirf(user: Preferences.idUs, intensidad: actividadesProvider.actividadesAlDia[i].intensidad!, duracion: actividadesProvider.actividadesAlDia[i].duracion!, actividad: actividadesProvider.actividadesAlDia[i].id, day: actividadesProvider.fechaAc, calorias: actividadesProvider.actividadesAlDia[i].calorias!);
        cargaFisica.add(_obj);
        }
}
class _CuerpoListBuil extends StatelessWidget {
  const _CuerpoListBuil({
    Key? key,
    required this.index,
    required this.actividadesProvider,
  }) : super(key: key);

  
  final int index;
  final ActividadesProvider actividadesProvider;
 
  

  @override
  Widget build(BuildContext context) {
  
  String rutaFile="";
   switch (actividadesProvider.actividadesAlDia[index].typeactivity) {
       case 1:
          rutaFile='assets/EXC.svg';
         break;
       case 2:
         rutaFile='assets/SPORTS.svg';
        break;
       case 3:
          rutaFile='assets/WORK.svg';
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
         actividadesProvider.actividadesAlDia.removeAt(index);
         actividadesProvider.notiCambiosac();        
        },
        child: Container(
           decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(0), color: Colors.grey[200]),
           child: ListTile(
             onTap: () => Navigator.pushNamed(context, 'actividadesDetalles', arguments: actividadesProvider.actividadesAlDia[index]),
            contentPadding:const EdgeInsets.only(left: 5,right: 2,top: 2,bottom: 2),
            dense: true,
            title: Text(actividadesProvider.actividadesAlDia[index].nombre,style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis,),
            subtitle:Text('Kcalorias quemadas '+actividadesProvider.actividadesAlDia[index].calorias.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,  ),
            leading: SvgPicture.asset(rutaFile,height: 40, width: 40,),
            trailing: IconButton( 
              padding: const EdgeInsets.only(right: 3),
            alignment: Alignment.centerRight,
            icon: const Icon(Icons.close_rounded, color: AppTheme.primary,), onPressed: (){
               actividadesProvider.actividadesAlDia.removeAt(index);
               actividadesProvider.notiCambiosac();
           },),
                    
                    
         ),
        ),
      ), 
    );
  }
}
class _CuerpoSugerencias extends StatelessWidget {
  const _CuerpoSugerencias({
    Key? key,
    required this.auxSuger,
    required this.index,
    required this.actividadesProvider,
  }) : super(key: key);

  final List<ActividadesFisicas> auxSuger;
  final ActividadesProvider actividadesProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
   
   String rutaFile="";
   switch (auxSuger[index].typeactivity) {
       case 1:
          rutaFile='assets/EXC.svg';
         break;
       case 2:
         rutaFile='assets/SPORTS.svg';
        break;
       case 3:
          rutaFile='assets/WORK.svg';
         break;   
     }

     return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        
        decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(0), color: Colors.grey[200]),
        child: ListTile(
          onTap: () => Navigator.pushNamed(context, 'actividadesDetalles', arguments: auxSuger[index]),
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
          
          leading:SvgPicture.asset(rutaFile,height: 40, width: 40,color: Colors.green),
          trailing: const Icon( Icons.arrow_forward_ios),
        
        
        ),
      ),
    );
  }
}


