import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:provider/provider.dart';

class DatosTresScreen extends StatelessWidget {
  const DatosTresScreen({Key? key}) : super(key: key);

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
        title:   SvgPicture.asset("assets/title.svg", fit: BoxFit.cover, height: 40,),
        ),
        body: const BodyDatosTres(),
        floatingActionButton:  FloatingActionButton.extended(
          onPressed:() {
            if(datosUserProvider.nombre.isEmpty){
             ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text("Nombre VACIO")));
           }
           else{
              Navigator.pushNamed(context, 'datosDos');
           }
          },
          label:const Text("Siguiente (3/4)"),
          backgroundColor: Colors.lightGreen,)
    );
  }
}

class BodyDatosTres extends StatelessWidget {
  const BodyDatosTres({
    Key? key,
  }) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    final datosUserProvider = Provider.of<DatosUserProvider>(context);
    final _peso = TextEditingController();
    final _altura= TextEditingController();
   
    return SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
         
            AutoSizeText(datosUserProvider.nombre+' Indica tu: ',style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
             const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const Expanded( flex:2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AutoSizeText("Peso: ", textAlign: TextAlign.end,style:  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1),
                    )),
                  Expanded(
                    flex:3,
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                          
                        onChanged: (value){
                       
                        },
                        inputFormatters: [
                         FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,3})?\.?\d{0,2}'))
                        ],
                        textAlign: TextAlign.center,
                        controller:_peso,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          
                          isDense: true,
                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: 'Peso',
                          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[300], )
                        ),
                  
                      ),
                    ),
                  ),
                  const Expanded( flex:2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("kg", style:  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)),
                    )),
                  
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const Expanded( flex:2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AutoSizeText("Altura: ", textAlign: TextAlign.end,style:  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1,),
                    )),
                  Expanded(
                    flex:3,
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                                     
                        onChanged: (value){
                         
                        },
                        inputFormatters: [
                         FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,3})?'))
                        ],
                        textAlign: TextAlign.center,
                        controller:_altura,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: 'Altura',
                          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[300], )
                        ),
                  
                      ),
                    ),
                  ),
                  const Expanded( flex:2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("cm", style:  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)),
                    )),
                  
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Text("tu IMC es", style:  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: const  [
                  Expanded(flex: 1,
                  child:Padding(
                       padding: EdgeInsets.symmetric( horizontal: 8, vertical:0),
                      child: AutoSizeText("Peso Bajo: ", textAlign: TextAlign.start,style:  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1,),
                    )),
                  Expanded(
                    flex:1,
                    child:Padding(
                       padding: EdgeInsets.symmetric( horizontal:8, vertical:0),
                      child: AutoSizeText(" IMC => 16.0 - 18.4", textAlign: TextAlign.start,style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1,),
                    )),
                ],
              )),
              SizedBox(
              width: double.infinity,
              child: Row(
                children: const  [
                  Expanded(flex: 1,
                  child:Padding(
                       padding: EdgeInsets.symmetric( horizontal: 8, vertical:0),
                      child: AutoSizeText("Peso normal: ", textAlign: TextAlign.start,style:  TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1,),
                    )),
                  Expanded(
                    flex:1,
                    child:Padding(
                      padding: EdgeInsets.symmetric( horizontal: 8, vertical:0),
                      child: AutoSizeText(" IMC => 18.5 - 25.0", textAlign: TextAlign.start,style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1,),
                    )),
                ],
              )),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: const  [
                  Expanded(flex: 1,
                  child:Padding(
                       padding: EdgeInsets.symmetric( horizontal: 8, vertical:0),
                      child: AutoSizeText("Sobrepeso: ", textAlign: TextAlign.start,style:  TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1,),
                    )),
                  Expanded(
                    flex:1,
                    child:Padding(
                       padding: EdgeInsets.symmetric( horizontal: 8, vertical:0),
                      child: AutoSizeText(" IMC => 25.0 - 40.0", textAlign: TextAlign.start,style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1,),
                    )),
                ],
              )),
            const SizedBox(height: 15),
            
                           
          ],
        ),
      )
    
    );
  }
}

