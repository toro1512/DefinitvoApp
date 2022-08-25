import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:nutri_saludapp/models/models.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:provider/provider.dart';

class PieSection extends StatelessWidget {
  const PieSection({Key? key}) : super(key: key);
  
 
  @override
  Widget build(BuildContext context) {
    final generalProvider = Provider.of<GeneralProvider>(context);
   
    List<charts.Series<Calorias, String>> serie=[
      charts.Series(
        data:generalProvider.dataGrafiPri,
        id:"ResumenCalórico",
        domainFn: (Calorias pops,_)=> pops.name,
        measureFn: (Calorias pops,_)=> pops.percent,
        colorFn: (Calorias pops,_)=> charts.ColorUtil.fromDartColor(pops.color),
      )
    ];
    return SizedBox(
      height: 100,
      width: 100,
      
      child: charts.PieChart<String>(serie,
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec:charts.MarginSpec.fixedPixel(0)),
      animate: true,
      defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 25, startAngle: 1/ 5 * pi, arcLength: 10/ 5 * pi)));
  }
}


