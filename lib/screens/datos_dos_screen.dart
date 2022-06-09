import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:provider/provider.dart';
class DatosDosScreen extends StatelessWidget {
  const DatosDosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final datosUserProvider = Provider.of<DatosUserProvider>(context);
    return  Scaffold(
        appBar: AppBar( 
        centerTitle:true,
        leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: (){
                  FocusScope.of(context).requestFocus( FocusNode());
                  Navigator.pop(context);
                } 
,
              );
            },
          ),
        backgroundColor:const Color.fromRGBO(234, 24, 77, 1),
        toolbarHeight: 60,
        title: const AutoSizeText ('Datos Personales', style: TextStyle(fontSize: 20),maxLines: 1,)
        ),
        body:  const BodyDatosDos(),
        floatingActionButton:  FloatingActionButton.extended(
          onPressed:() {
            if(datosUserProvider.sexo.isEmpty){
             ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text("Elige una opción")));
           }
           else{
              Navigator.pushNamed(context, 'datosTres');
           }
          },
          label:const Text("Siguiente (2/4)"),
          backgroundColor: Colors.lightGreen,)
        
    );
  }
}

class BodyDatosDos extends StatelessWidget {
  const BodyDatosDos({
    Key? key,
  }) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    final datosUserProvider = Provider.of<DatosUserProvider>(context);
      return SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              SvgPicture.asset("assets/NUTRISALUD-NS.svg", width: 150,),
              const SizedBox(height: 20),
              const AutoSizeText('¿Elige tu Sexo?',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(height: 15),
              
               GestureDetector(
                  onTap: (){
                    datosUserProvider.isPintar=false;
                    datosUserProvider.sexo="F";
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration( border: Border.all(color: 
                    !datosUserProvider.isPintar 
                    ?AppTheme.primary
                    :const Color.fromRGBO(1, 1, 1, 0), width: 2)
                    ),
                    width: 150,
                    height:150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Image.asset('assets/mujer.png',height: 100, width:100,),
                         const SizedBox(height:10),
                         const Text("Mujer")
                      ],),
                  ),
                ),
                const SizedBox(height:15),
              GestureDetector(
                onTap: (){
                  datosUserProvider.isPintar=true;
                  datosUserProvider.sexo="M";
                },
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(border: Border.all(color:
                  datosUserProvider.isPintar 
                    ?Colors.blue
                    :const Color.fromRGBO(1, 1, 1, 0), width: 2)
                   ),
                  width: 150,
                  height:150,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Image.asset('assets/hombre.png',height: 100, width:100,),
                       const SizedBox(height:10),
                       const Text("Hombre")
                    ],),
                )),
              
                     
            ],
          ),
        ),
      )
    
    );
  }
}

