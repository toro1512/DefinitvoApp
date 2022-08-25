import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/share_preferences/preferences.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:provider/provider.dart';

class ActividadesDetallesScreen extends StatelessWidget {
  const ActividadesDetallesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ActividadesFisicas actividad = ModalRoute.of(context)!.settings.arguments as ActividadesFisicas;
    final actividadesProvider= Provider.of<ActividadesProvider>(context);
    return Scaffold(
      appBar:  AppBar(
        title: const Text("Actividades", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppTheme.primary
        ),
      body:SingleChildScrollView(
        child:Column(
          children: [
             Image.asset('assets/actividadFisica.jpg',
            height:300,
            width:double.infinity,
            fit: BoxFit.cover,
            ),
             Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal:5),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.primary,), 
                  child: Text(actividad.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis,)),
              ),
             const SizedBox(height: 10),
            
         Padding(
          padding: const EdgeInsets.symmetric(vertical :3, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Duracion (min):", textAlign: TextAlign.right, style: TextStyle(fontSize: 16),),
                )),
              Expanded(
                flex: 2,
                child: TextFormField(
                            inputFormatters: [
                             FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,3})'))
                            ],
                            controller: actividadesProvider.duracionControl,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                            isDense: true,
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintStyle: TextStyle(fontSize: 16, color: Colors.grey[300], )
                            ),
                          ),
                ),
             ]
          ),
        ),
        SwitchListTile.adaptive(
            activeColor: AppTheme.primary,
            
            title: const Text('Intensidad Alta ', textAlign: TextAlign.right, style: TextStyle(fontSize: 16)),
            value: actividadesProvider.intensidadAlta, 
            onChanged: ( value ){
              if(value){
                  actividadesProvider.intensidadBaja=false; 
                  actividadesProvider.intensidadMedia=false;
                  actividadesProvider.registrarInt=1; 
                }
                else{
                  actividadesProvider.registrarInt=-1;
                }
                 actividadesProvider.intensidadAlta=value;
                 actividadesProvider.notiCambiosac();
            
            }
          ),
          SwitchListTile.adaptive(
            activeColor: AppTheme.primary,
            
            title: const Text('Intensidad Media ', textAlign: TextAlign.right, style: TextStyle(fontSize: 16)),
            value: actividadesProvider.intensidadMedia, 
            onChanged: ( value ){
              if(value){
                  actividadesProvider.intensidadAlta=false; 
                  actividadesProvider.intensidadBaja=false; 
                actividadesProvider.registrarInt=2; 
                }
                else{
                  actividadesProvider.registrarInt=-1;
                }
                 actividadesProvider.intensidadMedia=value;
                 actividadesProvider.notiCambiosac();
            
            }
          ),
          SwitchListTile.adaptive(
            activeColor: AppTheme.primary,
            
            title: const Text('Intensidad Baja ', textAlign: TextAlign.right, style: TextStyle(fontSize: 16)),
            value: actividadesProvider.intensidadBaja,
            onChanged: ( value ){
               
                if(value){
                  actividadesProvider.intensidadAlta=false; 
                  actividadesProvider.intensidadMedia=false; 
                actividadesProvider.registrarInt=3; 
                }
                else{
                  actividadesProvider.registrarInt=-1;
                }
                 actividadesProvider.intensidadBaja=value;
                 actividadesProvider.notiCambiosac();

            }
          ),

          
          ],
        )
      ), 
      floatingActionButton: Align(
        child: FloatingActionButton.extended(
        backgroundColor: Colors.lightGreen, 
        onPressed: () {
          if(actividadesProvider.registrarInt!=-1)
          {
       
           if(actividadesProvider.duracionControl.text.isNotEmpty){
            actividad.duration=int.parse(actividadesProvider.duracionControl.text);
            actividad.intensities=actividadesProvider.registrarInt;
            actividad.kquemadas=int.parse(actividadesProvider.duracionControl.text)*actividad.met*Preferences.pesoUs*0.0175 ;
            actividadesProvider.actividadesAlDia.add(copiarActividad(actividad));
            actividadesProvider.registrarInt=-1;
            actividadesProvider.duracionControl.text="";
            actividadesProvider.intensidadAlta=false;
            actividadesProvider.intensidadBaja=false;
            actividadesProvider.intensidadMedia=false;
            actividadesProvider.notiCambiosac();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(duration: Duration(seconds: 2),
              content: Text("Registro exitoso")));
           }
           else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(duration: Duration(seconds: 2),
              content: Text("Necesita la duracion")));
           }
           }
           else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(duration: Duration(seconds: 2),
              content: Text("Necesita ingresar una intensidad")));
           }
         
        },
        icon: const Icon(Icons.save),
        label: const Text("Cargar"),),
        alignment: const Alignment(0.0,1)
        
        ), 
    );
  }

  ActividadesFisicas copiarActividad(ActividadesFisicas actividad) {
   ActividadesFisicas _obj=ActividadesFisicas(id: actividad.id, nombre: actividad.nombre, typeactivity: actividad.typeactivity, met: actividad.met, kquemadas: actividad.kquemadas, duration:actividad.duration, intensities: actividad.intensities);
   return _obj;

  }
}