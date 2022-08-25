// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/screens/screens.dart';
import 'package:nutri_saludapp/services/services.dart';
import 'package:nutri_saludapp/share_preferences/preferences.dart';
import 'package:provider/provider.dart';


class CheckAuthScreen extends StatelessWidget {
   
  const CheckAuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);
    return  Scaffold(
      body: Center(
         child: FutureBuilder(
           future: authService.readInicio(),
           builder: (BuildContext context, AsyncSnapshot<String> snapshot)
           {
               
               
                if(!snapshot.hasData) {
                   return const Center(child: CircleAvatar());
                }
                if(snapshot.data =='')
                {
                  Future.microtask((){
                    Navigator.pushReplacement(context,PageRouteBuilder(
                      pageBuilder: (_,__,___)=> const BienvenidaScreen(),
                      transitionDuration: const Duration(seconds: 0)) 
                      );
                  });
                  
                  return Container();
                }
                else
                {
                if(snapshot.data =="vacio")
                {
                  Future.microtask((){
                    Navigator.pushReplacement(context,PageRouteBuilder(
                      pageBuilder: (_,__,___)=> const LoginScreen(),
                      transitionDuration: const Duration(seconds: 0)) 
                      );
                  });
                  
                  return Container();
                }
                else{
                  obtenerQuery(context);
                  Future.microtask((){
                     ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(duration: Duration(seconds: 2),
                          content: Text("Bienvenido")));
                      Navigator.pushReplacement(context,PageRouteBuilder(
                      pageBuilder: (_,__,___)=> const HomeScreen(),
                      transitionDuration: const Duration(seconds: 0)) 
                      );
                  });
                  
                  return Container();
                }
                }
           })
           
      ),
    );
  }

void obtenerQuery(context) async {
    final listaService = Provider.of<AlimentosDayService>(context, listen: false);
    final medidasService = Provider.of<MedidasService>(context, listen: false);
    final generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    final actividadesProvider = Provider.of<ActividadesProvider>(context, listen: false);
    final actividadesService = Provider.of<FisicasService>(context, listen: false);

    const storage = FlutterSecureStorage();
    final ValoresHistoria x,y;
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String fecha = formatter.format(now);
    actividadesProvider.fechaAc=fecha;
    generalProvider.fechaC=fecha;
    generalProvider.fechaM=fecha;
    generalProvider.fechaF=fecha;
    String val=await storage.read(key: 'usuario') ?? '';
    String val2;

    x=await actividadesService.caloriasConsu(Preferences.idUs.toString());
    y=await actividadesService.caloriasQuema(Preferences.idUs.toString());
    generalProvider.caloriasCon=x.gastoCalorico;
    generalProvider.caloriasQue=y.gastoCalorico;
    generalProvider.llenarGraficasCircular(y.gastoCalorico,x.gastoCalorico);

    val="'"+val+"'/";
    fecha='"'+fecha+'"';
    val= val+fecha;
    val2=Preferences.idUs.toString()+"/"+fecha;
    actividadesProvider.actividadesAlDiaHecha.addAll(await actividadesService.dayActividades(val2));
    actividadesProvider.todasActividades.addAll(await listaService.searchActividades());
    generalProvider.medidasTomar.addAll(await medidasService.searchMedidas());
    generalProvider.alimentosDay.addAll(await listaService.searchAlimentos(val));
    
     for(int i=0;i<generalProvider.medidasTomar.length;i++)
    {
      if(generalProvider.medidasTomar[i].typ=="1" ) {
          generalProvider.medidasFisicas.add(generalProvider.medidasTomar[i]);
        }
    }
    for(int i=0;i<generalProvider.alimentosDay.length;i++)
    {
      switch(generalProvider.alimentosDay[i].moment ) {

      case 'Almuerzo':
        generalProvider.almLisDay.add(generalProvider.alimentosDay[i]);
        break;
      case 'Cena': 
          generalProvider.cenLisDay.add(generalProvider.alimentosDay[i]);
        break;
      case 'Desayuno': 
         generalProvider.desLisDay.add(generalProvider.alimentosDay[i]);
        break;
      case 'Merienda': 
          generalProvider.merLisDay.add(generalProvider.alimentosDay[i]);
        break;
   
      }
    }
    for(int i=0;i<actividadesProvider.actividadesAlDiaHecha.length;i++)
    {
      switch(actividadesProvider.actividadesAlDiaHecha[i].typeactivity) {

      case 1:
        actividadesProvider.deportivasAlDia.add(actividadesProvider.actividadesAlDiaHecha[i]);
        break;
      case 2: 
          actividadesProvider.recreacionalesAlDia.add(actividadesProvider.actividadesAlDiaHecha[i]);
        break;
      case 3: 
         actividadesProvider.ocupacionalesAlDia.add(actividadesProvider.actividadesAlDiaHecha[i]);
        break;
      }
    }
    List<ModelosSubirm> _objects = List<ModelosSubirm>.generate(generalProvider.medidasFisicas.length, (index) { 
      ModelosSubirm _obj = ModelosSubirm(idUsers:-1, idPhysicalMeasures:-1, value: -1, measureDate: "-1", measureTime: "000", beforeAfter: 2, valueAlt: 0);
      return _obj;
     });
    generalProvider.medidasSubir.addAll(_objects); 
    
  }
}