import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as elements;
import 'package:charts_flutter/src/text_style.dart' as styles;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nutri_saludapp/models/models.dart';
import 'dart:math';

import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/services/services.dart';
import 'package:nutri_saludapp/share_preferences/preferences.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:provider/provider.dart';


class GlucosaScreen extends StatelessWidget {
  const GlucosaScreen({Key? key}) : super(key: key);
  

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
           const ConstruirGraficag(),
         ],
       ),
     ),
     
    );
  }
}
class _TomarMedidasTen extends StatelessWidget {
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
    final generalProvider= Provider.of<GeneralProvider>(context);
    final medidasService = Provider.of<MedidasService>(context, listen: false);
    List <ModelosSubirm> auxSubirFsica=[];
    int subirBefore;
    
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
                  child: Text("Glucemia", textAlign: TextAlign.right, style: TextStyle(fontSize: 16),),
                )),
              Expanded(
                flex: 2,
                child: TextFormField(
                            inputFormatters: [
                             FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,3})'))
                            ],
                            controller: generalProvider.axucarContr,
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
            
            title: const Text('Antes de comer ', textAlign: TextAlign.right, style: TextStyle(fontSize: 16)),
            value: generalProvider.antesComer, 
            onChanged: ( value ){
            generalProvider.antesComer=value;
            }),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.lightGreen,
            textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal)),
          onPressed:() async{
            if(generalProvider.axucarContr.text.isNotEmpty ){
            auxSubirFsica.clear();
            if(generalProvider.antesComer){
              subirBefore=1;
            }
            else{subirBefore=2;}
            DateTime now = DateTime.now();
            String _dateM = DateFormat('kk:mm:ss').format(now);
            ModelosSubirm _obj=ModelosSubirm(idUsers: Preferences.idUs, idPhysicalMeasures: 4, beforeAfter: subirBefore, value: double.parse(generalProvider.axucarContr.text), measureDate: generalProvider.fechaM, measureTime: _dateM, valueAlt: 0);
            auxSubirFsica.add(_obj);
            final String? respuesta=await medidasService.insertarMedidas(auxSubirFsica);
                      if(respuesta=="registro exitoso"){
                             generalProvider.axucarContr.text=''; 
                             Platform.isAndroid 
                             ? displayDialogAndroid( context )
                             : displayDialogIOS( context );
                           }
            
                     
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(duration: Duration(seconds: 2),
                          content: Text("Debe registrar ambos valores"))); 

            }
          },
          child: const Text("Guardar")),  
      ],
    );
  }
}
class ConstruirGraficag extends StatelessWidget{
  static String? pointerAmount;
  static String? pointerDay;

  const ConstruirGraficag({Key? key}) : super(key: key);
  
   @override
  Widget build(BuildContext context) {
   final generalProvider= Provider.of<GeneralProvider>(context);
   
 List<charts.Series<ExpensesGli, String>> series=[
      
        charts.Series<ExpensesGli,String>(
          id: 'Label',
          domainFn: (v,i)=>v.day,
          measureFn: (v,i)=>v.medida,
          colorFn: (v, i) => v.barColor,
          data:generalProvider.dataGlu,
        ),
      
    ];
     return Center(
        child: SizedBox(
        height: 350,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: charts.BarChart(
          
            series,
            barGroupingType: charts.BarGroupingType.stacked,
            customSeriesRenderers: [
           charts.BarTargetLineRendererConfig<String>(
              // ID used to link series to this renderer.
              customRendererId: 'customTargetLine',
              groupingType: charts.BarGroupingType.stacked)
        ],
             domainAxis: const charts.OrdinalAxisSpec(renderSpec: charts.SmallTickRendererSpec(labelRotation: 60, labelStyle: charts.TextStyleSpec(fontSize: 10))),
            selectionModels: [
              charts.SelectionModelConfig(
                changedListener: (charts.SelectionModel model){
                  if(model.hasDatumSelection){
                   pointerAmount=(model.selectedDatum[0].datum.medida)?.toString();
                   
                  }

              })
            ],
            behaviors: [
              charts.LinePointHighlighter(
                symbolRenderer: MySimbolRender()
              )
            ],
          )
          
        ),
      ),
     );
  }
}



class MySimbolRender extends charts.CircleSymbolRenderer{
 @override
  void paint(
    charts.ChartCanvas canvas,
    Rectangle<num> bounds, 
    {
       List<int>? dashPattern,
       charts.Color? fillColor,
       charts.FillPatternType? fillPattern,
       charts.Color?
       strokeColor,
       double? strokeWidthPx
    }) {
    
    super.paint(
      canvas,
      bounds, 
      dashPattern:dashPattern, 
      fillColor:fillColor, 
      fillPattern:fillPattern, 
      strokeColor:strokeColor, 
      strokeWidthPx:strokeWidthPx,
      );
      canvas.drawRect(
       Rectangle(
        bounds.left -25,
        bounds.top -30,
        bounds.width +48,
        bounds.height +18
        ),
      fill: charts.ColorUtil.fromDartColor(Colors.grey),
      stroke: charts.ColorUtil.fromDartColor(Colors.green),  
      strokeWidthPx: 2
      );
      var myStyle = styles.TextStyle();
      canvas.drawText(
        elements.TextElement('${ConstruirGraficag.pointerAmount}',
        style: myStyle
       ), 
       (bounds.left -10).round(), 
       (bounds.top -23).round());
  }
}

class Daoo {
 final String vaa;
 final  int pro;
 Daoo(this.vaa, this.pro);
}
