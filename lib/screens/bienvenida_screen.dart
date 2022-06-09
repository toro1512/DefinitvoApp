import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SizedBox(
           width: double.infinity,
           height: double.infinity,
           child: Padding(
             padding: const EdgeInsets.only(top: 100,left: 10,right: 10, bottom: 10 ),
             child: Column(
               children:  [
                 Image.asset('assets/nutriPantalla.png',height: 150, width:150,),
                 const SizedBox(height:20),
                 const AutoSizeText('Bienvenidos a NutriSalud', style : TextStyle( fontSize: 35, color: Colors.grey, fontWeight: FontWeight.w700), maxLines:1,),
                 Container(
                   margin: const EdgeInsets.only( left: 30, right: 30, top: 20, bottom: 20),
                   child: const AutoSizeText('Una app para mejorar tu estilo de vida y ver, que si se puede comer saludable', textAlign: TextAlign.center,style : TextStyle( fontSize: 22, color: Colors.black, fontWeight: FontWeight.w400), maxLines:3,),
                 ), 
                 const SizedBox(height:40),
                 MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.lightGreen,
                  elevation: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric( horizontal: 40, vertical: 15),
                    child: const Text('Comenzar',style: TextStyle( color: Colors.white ),)
                  ),
                  onPressed:(){
                     Navigator.pushNamed(context, 'datosPersonales');
                  },
                             
                 ),
                 const SizedBox(height:20), 
                  MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: AppTheme.primary,
                  elevation: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric( horizontal: 40, vertical: 15),
                    child: const Text('Iniciar Sesión',style: TextStyle( color: Colors.white ),)
                  ),
                  onPressed:(){
                     Navigator.pushNamed(context, 'login');
                  },
                             
                 ),
                 const SizedBox(height:20),
                 SvgPicture.asset('assets/NUTRISALUD-NS.svg'),           
               ],
             ),
           ),

        ),

    );
  }
}