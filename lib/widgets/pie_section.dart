import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieSection extends StatelessWidget {
  const PieSection({Key? key}) : super(key: key);
static List<Calorias> data =[
      Calorias('Quemadas',80.5, Colors.lightGreen),
      Calorias('Consumidas',19.5, const Color.fromRGBO(234, 24, 77, 1)),

  ];
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Calorias, String>> serie=[
      charts.Series(
        data:data,
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
class Calorias {
  final String name;
  final double percent;
  final Color  color;

  Calorias(this.name, this.percent, this.color);
}

