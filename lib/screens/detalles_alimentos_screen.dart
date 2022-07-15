import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:provider/provider.dart';

class DetallesAlimentosScreen extends StatelessWidget {
  const DetallesAlimentosScreen({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
   
 
   final Alimentos alimento = ModalRoute.of(context)!.settings.arguments as Alimentos;
   String selectedValue= "gr";
   int posicionC=0;
   final generalProvider=Provider.of<GeneralProvider>(context); 
   List<Alimentos> aux=[];
   final String  tituloS=generalProvider.tituloG;
   List<String>  itemsS = [];
   
   void llenar(List<Tipo> lis){
        for (var name in lis) {
          itemsS.add(name.name);
        }
   }
    switch( tituloS ) {

      case 'Almuerzo':
          aux=generalProvider.almuerosLista;
        break;
      case 'Cena': 
          aux=generalProvider.cenasLista;
        break;
      case 'Desayuno': 
          aux=generalProvider.desayunosLista;
        break;
      case 'Merienda': 
          aux=generalProvider.meriendasLista;
        break;
   
    }
   switch(alimento.grupo){
      
        case "Leche y Derivados" :
          llenar(generalProvider.tipoLiquido);
          selectedValue = 'ml';
          break;
        case "Bebidas (Alcoholicas y No Alcoholicas)" :
          llenar(generalProvider.tipoLiquido);
          selectedValue = 'ml';
          break;
        default :
          llenar(generalProvider.tipoSolido);
          selectedValue = 'gr';
          break;
      }
   

     
    return  Scaffold(
        appBar: AppBar(
        title: Text(tituloS),
        centerTitle: true,
        backgroundColor: AppTheme.primary
        ),
      body:  CuerpoBody(alimento: alimento), 
     
      floatingActionButton: Align(
        child: FloatingActionButton.extended(
        backgroundColor: Colors.lightGreen, 
        onPressed: () {
             if(generalProvider.valorTextEdit!=0){
              alimento.amount=alimento.amount*generalProvider.valorConversion*generalProvider.valorTextEdit;
             aux.add(alimento);
             Navigator.pushReplacementNamed(context, 'alimentos', arguments: tituloS);
             }
             else{
              ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(duration: Duration(seconds: 2),
              content: Text("Necesita ingresar un Valor")));
             }
        },
        icon: const Icon(Icons.save),
        label: const Text("Gargar"),),
        alignment: const Alignment(0.1,0.7)
        
        ),
      bottomSheet: Container(
        height: 80,
        color: Colors.black12,
        
               child: Row(
                 children: [
                   Expanded(
                     flex: 4,
                     child: Padding(
                     padding: const EdgeInsets.all(8.0),
                       child: Center(
                          child: TextField(
                               controller: generalProvider.cantidadControl,
                               decoration: InputDecoration(
                               labelText: 'Cantidad',
                               isDense: true,
                               focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(5.0),
                                   ),
                  
                  
                              ),
                               textAlign:TextAlign.center,
                   
                               keyboardType: const TextInputType.numberWithOptions(decimal: true),  
                               onChanged: (value) {
                                    if(value.isNotEmpty)
                                    {
                                     generalProvider.valorTextEdit=double.parse(value);
                                     generalProvider.notiCambios();
                                    }
                                    else{
                                      generalProvider.valorTextEdit=0;
                                    }
                                    
                               },                
                  
                               inputFormatters: [
                                 FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,4})?'))

                               ],)
                               ),
                          )
                   ),
                   Expanded(
                      flex: 6, 
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                          onTap: (){  },
                          value: selectedValue,
                          decoration: const InputDecoration(
                          border: OutlineInputBorder( gapPadding: 0,borderRadius: BorderRadius.only(bottomRight:Radius.circular(10), bottomLeft: Radius.circular(10)),), 
                          labelText: 'Unidad a Consumir',                
                          ),
                          onChanged: ( newValue){
                             selectedValue = newValue!;
                             posicionC=generalProvider.tipoSolido.indexWhere((element) => element.name==selectedValue) ;
                              if (posicionC==-1){
                                posicionC=generalProvider.tipoLiquido.indexWhere((element) => element.name==selectedValue) ;  
                                generalProvider.valorConversion=generalProvider.tipoLiquido[posicionC].vConversion;
                                generalProvider.cantidadControl.text=generalProvider.tipoLiquido[posicionC].vInicial.toString();
                              }
                              else{
                                generalProvider.valorConversion=generalProvider.tipoSolido[posicionC].vConversion;
                                generalProvider.cantidadControl.text=generalProvider.tipoSolido[posicionC].vInicial.toString();
                              }
                             
                             generalProvider.valorTextEdit=double.parse(generalProvider.cantidadControl.text);
                             if(generalProvider.cantidadControl.text.isNotEmpty)
                                {generalProvider.notiCambios();}
                             
                            },
                             items: itemsS.map<DropdownMenuItem<String>>(
                             (String value) => DropdownMenuItem<String>(
                                   value: value,
                                   child: Text(value),
                                 ))
                                .toList(),
                              icon:const Icon(Icons.arrow_drop_down),
                              iconSize: 30,
                         ),
                    ),
                  )
                 ],
               )
             ),
 
    );
  }
}


class CuerpoBody extends StatelessWidget {
  const CuerpoBody({
    Key? key,
    required this.alimento,
  }) : super(key: key);

  final Alimentos alimento;
  

  @override
  Widget build(BuildContext context) {
    final generalProvider=Provider.of<GeneralProvider>(context);
    return SingleChildScrollView(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start, 
        children: <Widget>[
        Stack(
          children: [
          Image.asset(
            'assets/fondoDetalle.jpg',
            height:180,
            width:double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
           
            children: [
               const SizedBox(height: 70,),
               Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal:5),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.primary,), 
                  child: Text(alimento.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis,)),
              ),
            ],
          )
        ],
        ), 
        
        Table(
         
          columnWidths: const {
            0:FractionColumnWidth(0.7)
          },
          children: [
            
            TableRow(
              children:[ 
                const _EtiquetaTabla(valorEti:'Carbohidratos en la porcion: '),
                _EtiquetaTabla(valorEti: (alimento.carbohidrato*generalProvider.valorConversion*generalProvider.valorTextEdit).toString()+' gr') 
              ]
            ),
            TableRow(
              children:[ 
                const _EtiquetaTabla(valorEti:'KCalorias en la porcion: '),
                _EtiquetaTabla(valorEti: (alimento.calorias*generalProvider.valorConversion*generalProvider.valorTextEdit).toString()+' gr') 
              ]
            ),
             TableRow(
              children:[ 
                 const _EtiquetaTabla(valorEti:'Grasas en la porcion: '),
                _EtiquetaTabla(valorEti:(alimento.lipids*generalProvider.valorConversion*generalProvider.valorTextEdit).toString()+ ' gr') 
              ]
            ),
            TableRow(
              children:[ 
                const _EtiquetaTabla(valorEti:'Proteinas en la porcion: '),
                _EtiquetaTabla(valorEti: (alimento.proteina*generalProvider.valorConversion*generalProvider.valorTextEdit).toString()+' gr') 
              ]
            )
          ],),//Flexible
        const SizedBox(height: 50),
       
        ], //<Widget>[]
       
        
        ), //Container
      );
  }
}

class _EtiquetaTabla extends StatelessWidget {
  const _EtiquetaTabla({
    Key? key,
    required this.valorEti, 
  }) : super(key: key);

  final String valorEti;

  @override
  Widget build(BuildContext context) {
    return Container(
               
               margin: const EdgeInsets.only(left: 5, right: 5, top: 5 ),
               padding: const EdgeInsets.symmetric(vertical: 3, horizontal:5),
               decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               color: AppTheme.primary,), 
               child: Text(valorEti , style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis,));
  }
}
