import 'package:flutter/material.dart';

class DetallesAlimentoScreen extends StatelessWidget {
  const DetallesAlimentoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(
        title:  const Center(child:Text('DetallesALimentos')),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('DetallesAlimento'),
            Text('botones'),
          ],
        ),
      ),
      bottomSheet: const ValorUnidad(),
    );
  }
}

class ValorUnidad extends StatefulWidget {
  const ValorUnidad({
    Key? key,
  }) : super(key: key);

  @override
  State<ValorUnidad> createState() => _ValorUnidadState();
 
}

class _ValorUnidadState extends State<ValorUnidad> {
   String selectCity='hola';
   final textcontroller= TextEditingController();
  
   @override
   void initState() {
     textcontroller.text='100';
   super.initState();
  
}
   
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 160,
        color: Colors.red,
        child: Column(
          children: [
              TextField(
               controller: textcontroller,
               onChanged: (value) {
               },
    
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: DropdownButtonFormField<String>(
                 items:const[
                 DropdownMenuItem(child: Text('hola'), value: 'hola'),
                 DropdownMenuItem(child: Text('perro'), value: 'perro'),
                 DropdownMenuItem(child: Text('gramos'), value: 'gramos'),
    
               ],
               onChanged: (value) => {
                 if (value==null)
                    value='hola',
                 setState((){
                  textcontroller.text=value!;
                 })
               },
               ),
             )
            ],
        ),),
    );
  }
}