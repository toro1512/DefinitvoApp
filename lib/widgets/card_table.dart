import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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

      return Container(
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
                       child: GestureDetector(child: SvgPicture.asset("assets/INFO.svg",height: 40,width: 40,)),
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
}


