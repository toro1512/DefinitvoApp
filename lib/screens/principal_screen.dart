import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/screens/screens.dart';
import 'package:nutri_saludapp/services/services.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:nutri_saludapp/widgets/widgets.dart';
import 'package:provider/provider.dart';


class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        title: SvgPicture.asset("assets/NUTRISALUD-NS.svg", width: 150,color: Colors.white,),
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
            color: Colors.grey,            
            onSelected: (item)=> _onSelected(context, item),
            itemBuilder: (context)=>[
              PopupMenuItem(
                value: 0,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                         children:const[
                           Icon(Icons.settings, color: Colors.black),
                           SizedBox(width:8),
                           Text('Setting', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                         ],
                       ),
                ),
               ),
               PopupMenuItem(
                value: 1,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                         children:const[
                           Icon(Icons.person, color: Colors.black),
                           SizedBox(width:8),
                           Text('Perfil', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                         ],
                       ),
                ),
               ),
              PopupMenuItem(
              
                value: 2,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                         children:const[
                           Icon(Icons.logout, color: Colors.black),
                           SizedBox(width:8),
                           Text('Cerrar Sesion', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                         ],
                       ),
                ),
               ),
                

            ])
        ],
      ),
       body: const BodyHome(),
      
      
    );
          // Home Body
       
      
      
   
  }
}

void _onSelected(BuildContext context, int item) {
   final authService = Provider.of<AuthService>(context, listen:false);
  
  switch(item){

    case 0:
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=> const ValoresScreen()),
      );
      break;
     case 1:
       break;
      case 2:
       authService.logout();
        Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=> const LoginScreen()),
      );
      break;
                 
  }

}

class BodyHome extends StatelessWidget {
  const BodyHome({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
     final generalProvider=Provider.of<GeneralProvider>(context);
     final Size size= MediaQuery.of(context).size;
    
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
              const MyFecha(),
              const SizedBox(height: 3),
             
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Row(
                  children: [
                    Flexible(fit: FlexFit.tight,child: AutoSizeText('resumen',style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold,fontSize: 30),maxLines: 1,textAlign: TextAlign.center)),
                    Flexible(fit: FlexFit.tight,child: AutoSizeText('calórico',style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.bold, fontSize: 30),maxLines: 1,textAlign: TextAlign.center,)),
                    
                    const Flexible(fit: FlexFit.tight,child: PieSection())
                 
                  ],
                ),
              ),
            
            const SizedBox(height: 10),
             
            Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
            
             const SizedBox(width:20), 
             AutoSizeText(generalProvider.caloriasCon.toString() + '  ',style: const TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold, fontSize: 16)),
             Expanded(child: AutoSizeText('calorias consumidas el actual dia',style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold, fontSize:16),maxLines: 1)),
            ]),
            Row(
             
               children: [
               const SizedBox(width: 20,), 
                AutoSizeText(generalProvider.caloriasQue.toString() + '  ',style: const TextStyle(color: Color.fromRGBO(234, 24, 77, 1), fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.start,),
               Expanded(child: AutoSizeText('calorias quemadas el actual dia',style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold, fontSize: 16),maxLines: 1)),
              ]),
            const SizedBox(height: 25),
            const CardTable(),
            const SizedBox(height: 5),
           
            Stack(
              children: <Widget>[
                Text('actividades',
                    style: TextStyle(
                    fontSize: 35,
                    foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.grey[700]!,
                    ),
                ),
                Text('actividades',
                   style: TextStyle(
                   fontSize: 35,
                   color: Colors.grey[400],
                   ),
               ),
             ],
            ),
               
            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap:() => Navigator.pushNamed(context, 'actividades', arguments: 'Deportivas'),
                  child:Container(
                   padding: const EdgeInsets.symmetric(horizontal:5),
                   width: size.width*0.30,
                   height: 100,
                   decoration: BoxDecoration( color:const Color.fromRGBO(234, 24, 77, 1),borderRadius: BorderRadius.circular(10)),
                   child: 
                      Column(
                        children: [
                          Expanded(flex:5,child: SvgPicture.asset("assets/EXC.svg",height: 40,width: 40, color: Colors.white)),
                          const SizedBox(height: 1,),
                          const Expanded(flex:2,child: AutoSizeText('deportivas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),maxLines:1, minFontSize:8 ), ),
                          const Divider(height: 3, thickness:2,),
                          const Expanded( flex: 2,
                           child:SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: AutoSizeText("Consumo 5 Kcal",
                                style: TextStyle(color: Colors.white,fontSize: 12 ,fontWeight: FontWeight.normal),
                                textAlign:TextAlign.center, maxLines:1, minFontSize:8)
                               )
                            )
                          )
                        ],
                      ),
                  )
                 ), 
                 GestureDetector(
                  onTap: ()  => Navigator.pushNamed(context, 'actividades', arguments: 'Ocupacionales'),
                  child:Container(
                   padding: const EdgeInsets.symmetric(horizontal:5),
                   width: size.width*0.30,
                   height: 100,
                   decoration: BoxDecoration( color:const Color.fromRGBO(234, 24, 77, 1),borderRadius: BorderRadius.circular(10)),
                   child: 
                      Column(
                        children: [
                          Expanded(flex:5,child: SvgPicture.asset("assets/WORK.svg",height: 40,width: 40, color: Colors.white)),
                          const SizedBox(height: 1,),
                          const Expanded(flex:2,child: AutoSizeText('ocupacionales', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),maxLines:1, minFontSize:8), ),
                          const Divider(height: 3, thickness:2,),
                          const Expanded( flex: 2,
                           child:SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: AutoSizeText("Consumo 5 Kcal",
                                style: TextStyle(color: Colors.white,fontSize: 12 ,fontWeight: FontWeight.normal),
                                textAlign:TextAlign.center, maxLines:1, minFontSize:8)
                               )
                            )
                          )
                        ],
                      ),
                  )
                 ),
                 GestureDetector(
                  onTap: ()  => Navigator.pushNamed(context, 'actividades', arguments: 'Recreacionales'),
                  child:Container(
                   padding: const EdgeInsets.symmetric(horizontal:5),
                   width: size.width*0.30,
                   height: 100,
                   decoration: BoxDecoration( color:const Color.fromRGBO(234, 24, 77, 1),borderRadius: BorderRadius.circular(10)),
                   child: 
                      Column(
                        children: [
                          Expanded(flex:5,child: SvgPicture.asset("assets/SPORTS.svg",height: 40,width: 40, color: Colors.white)),
                          const SizedBox(height: 1,),
                          const Expanded(flex:2,child: AutoSizeText('recreacionales', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),maxLines:1, minFontSize:10), ),
                          const Divider(height: 3, thickness:2,),
                          const Expanded( flex: 2,
                           child:SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: AutoSizeText("Consumo 5 Kcal",
                                style: TextStyle(color: Colors.white,fontSize: 12 ,fontWeight: FontWeight.normal),
                                textAlign:TextAlign.center, maxLines:1, minFontSize:8)
                               )
                            )
                          )
                        ],
                      ),
                  )
                 ),
              ],
            ),
            const SizedBox(height: 5),
                
            
            const SizedBox(height:10),
            
          ],
        ),
      ),
    );
  }
   
}

class MyFecha extends StatefulWidget {
  const MyFecha({Key? key}) : super(key: key);

  @override
  _MyFechaState createState() => _MyFechaState();
}

class _MyFechaState extends State<MyFecha> {
  @override
void initState() {
  super.initState();
   initializeDateFormatting();
  
}
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2022),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != currentDate) {

    final listaService = Provider.of<AlimentosDayService>(context, listen: false);
    final generalProvider = Provider.of<GeneralProvider>(context, listen: false);
     final actividadesProvider = Provider.of<ActividadesProvider>(context, listen: false);
    const storage = FlutterSecureStorage();

    
    var formatter = DateFormat('yyyy-MM-dd');
    String fecha = formatter.format(pickedDate);
    generalProvider.fechaC=fecha;
    actividadesProvider.fechaAc=fecha;
    String val=await storage.read(key: 'usuario') ?? '';
    val="'"+val+"'/";
    fecha='"'+fecha+'"';
    val= val+fecha;
    generalProvider.clearVectores();
    generalProvider.alimentosDay.addAll(await listaService.searchAlimentos(val)); 
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
      setState(() {
        currentDate = pickedDate;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
  return 
  PhysicalModel(
  color: Colors.white,
 
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    
     Flexible(
       flex: 5,
       fit: FlexFit.tight,
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: AutoSizeText(DateFormat('EEEE, d  MMMM  ''yyyy','es_ES').format(currentDate),
         style: const TextStyle(fontSize: 22, ), maxLines: 1, textAlign:TextAlign.center
         ),
       ),
     ),
     Flexible(
       flex: 1,
       fit: FlexFit.tight,
       child: IconButton(
             onPressed: () => _selectDate(context),
             icon:  SvgPicture.asset("assets/DATE.svg",
             color: Colors.lightGreen,
            height: 30,
            width: 30,
            ),
           ),
     ),],
       
       
       ),
        );
  }
}
