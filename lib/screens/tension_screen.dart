import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/services/services.dart';
import 'package:nutri_saludapp/share_preferences/preferences.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class TensionScreen extends StatelessWidget {
  const TensionScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        title: SvgPicture.asset("assets/NUTRISALUD-NS.svg", width: 150,color: Colors.white,),
        elevation: 0,
     ),
     body:SingleChildScrollView(
       child: Column(
         children: [
           _TomarMedidasTen(),
           _ConstruirGrafica(),
         ],
       ),
     ),
      
    );
  }
}

class _TomarMedidasTen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final generalProvider= Provider.of<GeneralProvider>(context);
    final medidasService = Provider.of<MedidasService>(context, listen: false);
    List <ModelosSubirm> auxSubirFsica=[];
    
    return Column(
      children: [
         const SizedBox(height: 10),
         Text("Fecha: "+generalProvider.fechaM, style: const TextStyle(fontSize: 22)),
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
                  child: Text("Sístole", textAlign: TextAlign.right, style: TextStyle(fontSize: 16),),
                )),
              Expanded(
                flex: 2,
                child: TextFormField(
                            inputFormatters: [
                             FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,3})'))
                            ],
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
    
        Padding(
          padding: const EdgeInsets.symmetric(vertical :3, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Diástole", textAlign: TextAlign.right, style: TextStyle(fontSize: 16),),
                )),
              Expanded(
                flex: 2,
                child: TextFormField(
                            inputFormatters: [
                             FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,3})'))
                            ],
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.lightGreen,
            textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal)),
          onPressed:() async{
            auxSubirFsica.clear();
            DateTime now = DateTime.now();
            String _dateM = DateFormat('kk:mm:ss').format(now);
            ModelosSubirm _obj=ModelosSubirm(idUsers: Preferences.idUs, idPhysicalMeasures: 5, beforeAfter: 1, value: 120, measureDate: generalProvider.fechaM, measureTime: _dateM, valueAlt: 80);
            auxSubirFsica.add(_obj);
            final String? respuesta=await medidasService.insertarMedidas(auxSubirFsica);
                      if(respuesta=="registro exitoso"){
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(duration: Duration(seconds: 2),
                          content: Text("Cargo")));                      }

          },
          child: const Text("Guardar")),  
      ],
    );
  }
}

class _ConstruirGrafica extends StatelessWidget{
  
   @override
  Widget build(BuildContext context) {
    final data= [
      Expenses("0", 120),
      Expenses("1", 130),
      Expenses("2", 125),
      Expenses("4", 125),
     
    ];
    final data2 = [
      Expenses("0", 70),
      Expenses("1", 80),
      Expenses("2", 85),
      Expenses("4", 85),
    ];

List<charts.Series<Expenses, String>> series = [
      charts.Series<Expenses, String>(
        id: 'Lineal',
        domainFn: (Expenses pops,_) => pops.day,
        measureFn: (Expenses pops,_) => pops.medida,
        data: data,
        labelAccessorFn:(Expenses pops,_)=>'${pops.medida}'
        
      ),
      charts.Series<Expenses, String>(
        id: 'Lineal',
        domainFn: (Expenses pops,_) => pops.day,
        measureFn: (Expenses pops,_) => pops.medida,
        data: data2,
        labelAccessorFn:(Expenses pops,_)=>'${pops.medida}'
      )
     
    ];
  
    return Center(
      child: SizedBox(
        height: 350,
        width: double.infinity,
        child: charts.BarChart(
          series,
           barRendererDecorator:  charts.BarLabelDecorator(
               insideLabelStyleSpec: const charts.TextStyleSpec( ),
               outsideLabelStyleSpec: const  charts.TextStyleSpec()),
          
        
          ),
      ));
  }
}
class Expenses{
  final String day;
  final int medida;
  Expenses(this.day, this.medida);
}
/*
final data2 = [
      Expenses(2, 250),
      Expenses(3, 124),
      Expenses(4, 345),
      Expenses(5, 276),
    ];

List<charts.Series<Expenses, int>> series = [
      charts.Series<Expenses, int>(
        id: 'Lineal',
        domainFn: (v,i) => v.day,
        measureFn: (v,i) => v.expense,
        data: data
      ),
      charts.Series<Expenses, int>(
        id: 'Lineal',
        domainFn: (v,i) => v.day,
        measureFn: (v,i) => v.expense,
        data: data2
      )
    ];

*/