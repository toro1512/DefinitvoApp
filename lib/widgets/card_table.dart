import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:provider/provider.dart';


class CardTable extends StatelessWidget {
  const CardTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: const [
          _SigleCard( color: Colors.white, icon: "assets/DesayunoBanner.jpg", text: 'Desayuno' ,ruta: 'alimentos',),
          _SigleCard( color: Colors.white, icon: "assets/AlmuerzoBanner.jpg", text: 'Almuerzo',ruta: 'alimentos' ),
          _SigleCard( color: Colors.white, icon:"assets/MeriendaBanner.jpg", text: 'Merienda',ruta: 'alimentos' ),       
          _SigleCard( color: Colors.white, icon: "assets/CenaBanner.jpg", text: 'Cena' ,ruta: 'alimentos'),       
        ],

    );
  }
}


class _SigleCard extends StatelessWidget {

  final String icon;
  final Color color;
  final String text;
  final String ruta;

  const _SigleCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
    required this.ruta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size= MediaQuery.of(context).size;
    final generalProvider=Provider.of<GeneralProvider>(context);

      return Container                          (
          margin: const EdgeInsets.all(1),
          child: GestureDetector(
           
            onTap: () => Navigator.pushNamed(context, ruta, arguments: text),
            child: Stack(
               children: [
                 Image.asset(icon, width: size.width,height: 70, fit: BoxFit.cover,),
                 Row(
                   
                   children: [
                     
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 15, horizontal:10),
                       child: GestureDetector(child: SvgPicture.asset("assets/INFO.svg",height: 40,width: 40,),
                        onTap: (){
                           showComida(context, generalProvider);
                        },),
                     ),
                     Expanded(
                       child: SizedBox(
                         height: 70,
                         child: Column(
                           children: [
                             Expanded(flex:1,child: Text( "carga aqui tu" , style: TextStyle( color: color, fontSize: 12,), maxLines: 2, textAlign: TextAlign.end, )),
                             Expanded(flex:3,child: AutoSizeText( text , style: TextStyle( color: color, fontSize: 50, fontWeight: FontWeight.bold), maxLines: 1, textAlign: TextAlign.center, )),
                             ],
                         ),
                       ),
                     ),
                   ],
                 ),
                
              ],
            ),
          ),
    );
  }

  Future<dynamic> showComida(BuildContext context, GeneralProvider generalProvider) {
    List<AlimentosDia> _aux =[];

    
    return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              if(text=='Cena'){
                                _aux.clear();
                                _aux=generalProvider.cenLisDay;
                              }
                              if(text=='Desayuno'){
                                 _aux.clear();
                                 _aux=generalProvider.desLisDay;
                              }
                              if(text=='Almuerzo'){
                               _aux.clear();
                               _aux=generalProvider.almLisDay; 
                              }
                              if(text=='Merienda'){
                                _aux.clear();
                                _aux=generalProvider.merLisDay; 
                              }
                              return AlertDialog(
                                shape:const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                titlePadding: const EdgeInsetsDirectional.only(start: 0, bottom: 0),
                                title: Container(
                                  width: double.infinity,
                                  color: AppTheme.primary,
                                  child: Center(child: Padding(
                                    padding:  const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(text, textAlign:TextAlign.center,style:const TextStyle(color:Colors.white),),
                                        const Text("cargado este dia", textAlign:TextAlign.center,style: TextStyle(color:Colors.white, fontSize: 8),),
                                      ],
                                    ),
                                  )),
                                  ),

                                contentPadding: const EdgeInsetsDirectional.only(start: 0, bottom: 0),  
                                content:
                                
                                 SizedBox(
                                   height: 400.0, // Change as per your requirement
                                   width: 300.0,
                                   child: Column(
                                    
                                     children: [
                                      if(_aux.isNotEmpty) ...[
                                       SizedBox(
                                        height: 390,
                                         child: ListView.separated(
                                      
                                          separatorBuilder: (context, index) => const Divider(height: 10, color: Colors.lightGreen),
                                          shrinkWrap: true,
                                          itemCount: _aux.length,
                                          itemBuilder: (BuildContext context, int index) {
                                             return ListTile(
                                              
                                              title: Text(_aux[index].food),
                                              subtitle: Text("consumiste " +_aux[index].kcal.toString()+ " Kcal"),
                                             );
                                           },
                                         ),
                                       )
                                       ,
                                       const SizedBox(
                                        height: 5,
                                       )
                                      ]
                                      else ...[
                                        const SizedBox(
                                        height: 20,
                                       ),
                                        const Center(child: Text("No tiene registros este dia"),)
                                      ]
                                     ],
                                   ),
                                 )
                              );
                            });
  }
}


