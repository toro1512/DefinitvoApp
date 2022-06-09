import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:provider/provider.dart';
class DatosPersonalesScreen extends StatelessWidget {
  const DatosPersonalesScreen({Key? key}) : super(key: key);

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
        body: const BodyDatosPersona(),
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
          label:const Text("Siguiente (1/4)"),
          backgroundColor: Colors.lightGreen,)
    );
  }
}

class BodyDatosPersona extends StatelessWidget {
  const BodyDatosPersona({
    Key? key,
  }) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    final datosUserProvider = Provider.of<DatosUserProvider>(context);
    final myController = TextEditingController();
   
    return SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            SvgPicture.asset("assets/NUTRISALUD-NS.svg", width: 150,),
            const SizedBox(height: 30),
            const AutoSizeText('¿Cual es tu Nombre?',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25)),
            TextFormField(
                           
              onChanged: (value){
                datosUserProvider.nombre=myController.text;
              },
              textAlign: TextAlign.center,
              controller:myController,
              keyboardType: TextInputType.text,
              autofocus:true,
              textCapitalization: TextCapitalization.words ,
              decoration: InputDecoration(
                isDense: true,
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Tu Nombre',
                hintStyle: TextStyle(fontSize: 20, color: Colors.grey[300], )
              ),

            ),
            const SizedBox(height: 40),
            const AutoSizeText('Fecha de Nacimiento',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 24)),
            DatePickerWidget(
              initialDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: -(365 * 8))),
              firstDate: DateTime.now().add(const Duration(days: -(365 * 100))),
              dateFormat: "dd-MM-yyyy",
              locale: DatePicker.localeFromString("es"),
              onChange: (value, selectedIndex) => datosUserProvider.fecha= value,
              pickerTheme: DateTimePickerTheme(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  dividerColor: AppTheme.primary),
            ),
            const SizedBox(height:30),
                   
          ],
        ),
      )
    
    );
  }
}

