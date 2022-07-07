import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';
import 'package:nutri_saludapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ValoresScreen extends StatelessWidget {
  const ValoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        title: SvgPicture.asset("assets/NUTRISALUD-NS.svg", width: 150,color: Colors.white,),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){},
                child: const Text("guardar")),
              Container(
                height: 500,
                child: ListView.builder(
                  
                  itemBuilder:(context, index) =>  DatosMedidas(indice:index, valorPedir:generalProvider.medidasFisicas[index].pmName,labelMedida:generalProvider.medidasFisicas[index].puName), 
                  shrinkWrap: true,
                  itemCount: generalProvider.medidasFisicas.length),
              ),
                          
            ],
          ),
        ),
      )
    
    );
    
  }
}