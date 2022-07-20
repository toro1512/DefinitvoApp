import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/services/services.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:nutri_saludapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ValoresScreen extends StatelessWidget {
  const ValoresScreen({Key? key}) : super(key: key);
  
  
   void displayDialogIOS( BuildContext context ) {
    showCupertinoDialog(
      barrierDismissible: false,
      context: context, 
      builder: ( context ) {
        return CupertinoAlertDialog(
          title: const Text('Titulo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              const Text('Registro Exitoso'),
              const SizedBox( height: 10 ),
              SvgPicture.asset('assets/NUTRISALUD-NS.svg'), 
            ],
          ),
          actions: [

            
            TextButton(
              onPressed: () {
                Navigator.of(context)..pop()..pop();
              },
              child: const Text('Ok')
            ),

          ],
        );
      }
    );

  }

  void displayDialogAndroid(BuildContext context) {
    
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: ( context ) {

        return AlertDialog(
          elevation: 5,
          title:  SvgPicture.asset('assets/NUTRISALUD-NS.svg'), 
          shape: RoundedRectangleBorder( borderRadius: BorderRadiusDirectional.circular(10) ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:const [
               Text('Registro Exitoso'),
               SizedBox( height: 10 ),
               
            ],
          ),
          actions: [

          
             TextButton(
              onPressed: () {
                Navigator.of(context)..pop()..pop();
              },
              child: const Text('Ok')
            ),

          ],
        );
        
      }
    );


  }

  @override
  Widget build(BuildContext context) {
     List <ModelosSubirm> auxSubirFsica=[];
     final generalProvider = Provider.of<GeneralProvider>(context, listen: false);
     final medidasService = Provider.of<MedidasService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        title: SvgPicture.asset("assets/NUTRISALUD-NS.svg", width: 150,color: Colors.white,),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text("Fecha: "+generalProvider.fechaM, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  
                  itemBuilder:(context, index) =>  DatosMedidas(indice:index, valorPedir:generalProvider.medidasFisicas[index].pmName,labelMedida:generalProvider.medidasFisicas[index].puName), 
                  shrinkWrap: true,
                  itemCount: generalProvider.medidasFisicas.length),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
                textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal)),
                onPressed: ()async{
                  int i=_llenarEnvio(generalProvider.medidasSubir,auxSubirFsica);
                  if(i>0){
                      final String? respuesta=await medidasService.insertarMedidas(auxSubirFsica);
                      if(respuesta=="registro exitoso"){
                                               
                         auxSubirFsica.clear();
                          Platform.isAndroid 
                             ? displayDialogAndroid( context )
                             : displayDialogIOS( context );
                      }
                     
                  }
                  
                },
                child: const Text("guardar")
              ),
              const SizedBox(height: 30,),
              Image.asset('assets/silueta.png',height: 200, width:200,), 

            ],
            
          ),
        ),
      )
    
    );
    
  }

  int _llenarEnvio(List<ModelosSubirm> medidasSubir, List<ModelosSubirm> auxSubirFsica) {
    for(int i=0; i<medidasSubir.length;i++){
      if(medidasSubir[i].value!= -1){
        auxSubirFsica.add(medidasSubir[i]);
      }
    }
    if(auxSubirFsica.isNotEmpty)
    {
      DateTime now = DateTime.now();
      String dateM = DateFormat('kk:mm:ss').format(now);
      for(int i=0; i<auxSubirFsica.length;i++)
      {
        auxSubirFsica[i].measureTime=dateM;
      }        
      
    }
    return auxSubirFsica.length;
  }

  
}
