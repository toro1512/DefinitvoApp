import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/screens/screens.dart';
import 'package:nutri_saludapp/services/services.dart';
import 'package:nutri_saludapp/share_preferences/preferences.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';


class ValoresPersonalesScreen extends StatelessWidget {
  const ValoresPersonalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List <String> valores=["Presión arterial","Glucosa en la sangre", "Medidas"];
    final medidasService = Provider.of<MedidasService>(context, listen: false); 
    final generalProvider = Provider.of<GeneralProvider>(context, listen: false);  
    String valor='';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        title: SvgPicture.asset("assets/NUTRISALUD-NS.svg", width: 150,color: Colors.white,),
        elevation: 0,
      ),
      body: SingleChildScrollView(
         child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child:  Column(
          children: [
           const SizedBox(height: 20),
           const FechaValores(),
           const SizedBox(height: 20),
           SizedBox(
            
            width: double.infinity,
            child: Column(
              children: [
                const Center(child: AutoSizeText('Valores Control',style: TextStyle(fontSize: 20))),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder:(context, index) => ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  leading: const Icon(Icons.circle_outlined),
                  title:  Text(valores[index]), 
                   onTap:() async {
                    valor=Preferences.idUs.toString();
                    generalProvider.medidasHistico.clear();  
                    if(index==0){
                     valor=valor+'/5';
                     generalProvider.medidasHistico.addAll(await medidasService.historialMedidas(valor));
                     generalProvider.llenarGraficas();
                     Navigator.of(context).push(
                     MaterialPageRoute(builder: (context)=> const TensionScreen()),
                     );}
                     else
                     if(index==1){
                     valor=valor+'/4';
                     generalProvider.medidasHistico.addAll(await medidasService.historialMedidas(valor)); 
                     generalProvider.llenarGraficasGlu();
                     Navigator.of(context).push(
                     MaterialPageRoute(builder: (context)=> const GlucosaScreen()),
                     );}
                    },
                  ),
                  separatorBuilder:((_,__)=> const Divider()), 
                  itemCount: valores.length-1
                  )
              ],
            )
            ),
           const SizedBox(height: 10),
           SizedBox(
         
            width: double.infinity,
            child:  Column(
              children: [
                const Center(child:AutoSizeText('Medidas Fisicas',style: TextStyle(fontSize: 20))),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder:(context, index) => ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                   onTap:(){
                     Navigator.of(context).push(
                     MaterialPageRoute(builder: (context)=> const ValoresScreen()),);},
                  leading: const Icon(Icons.circle_outlined),
                  title:  Text(valores[2]), ),
                  separatorBuilder:((_,__)=> const Divider()), 
                  itemCount: 1
               )
              ],
            )),
           
             
          ],
        )
        )


      ),
    );
     
  }
}
class FechaValores extends StatefulWidget {
  const FechaValores({Key? key}) : super(key: key);

  @override
  _FechaValoresState createState() => _FechaValoresState();
}

class _FechaValoresState extends State<FechaValores> {
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
        lastDate: DateTime.now(),
       );
    if (pickedDate != null && pickedDate != currentDate) {
  
      setState(() {
        currentDate = pickedDate;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
   final generalProvider= Provider.of<GeneralProvider>(context);
   generalProvider.fechaM=DateFormat('yyyy-MM-dd').format(currentDate);
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
            height: 30,
            width: 30,
            color: Colors.lightGreen
            ),
           ),
     ),],
       
       
       ),
        );
  }
}


