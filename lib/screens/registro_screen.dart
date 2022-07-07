import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/services/services.dart';
import 'package:nutri_saludapp/ui/input_decoration.dart';
import 'package:nutri_saludapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({ Key? key }) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      body: AuthBackground(child:SingleChildScrollView(
         child: Column(
          children:  [
           
             const SizedBox(height:200),
           
             CardContainer(child:  Column(
               children: [
                
                 const SizedBox(height: 10),
                 Text('Crear Cuenta ', style: Theme.of(context).textTheme.headline5),

                  ChangeNotifierProvider(
                    create: ( _ ) => LoginFormProvider(),
                    child: const _FormLogin())
               ],
             ),),

             const SizedBox(height: 50),
             TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all( Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const  StadiumBorder() )
                ),
                child: const Text('¿Ya tienes una cuenta?', style: TextStyle( fontSize: 18, color: Colors.black87 ),)
              ),
             const SizedBox(height: 50),
           ],)
          )),
    );
  }
}
class _FormLogin extends StatelessWidget {
  const _FormLogin({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
     const storage = FlutterSecureStorage();
     final loginForm = Provider.of<LoginFormProvider>(context);
     final datosUsProvider = Provider.of<DatosUserProvider>(context);

    return Container (
      padding: const EdgeInsets.all(5),
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column
        (children: [

          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Correo',
              labelText: 'Correo Usuario',
              prefixIcon: Icons.alternate_email_rounded
              ),
            onChanged: (value) => loginForm.email=value,  
            validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  =  RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                ? null
                :'El valor no tiene formato de correo';
              },
                           
           ),

           const  SizedBox( height: 30 ),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginForm.password=value,
              validator: (value) {
                return (value != null && value.length >= 6)
                ? null
                : 'la contraseña debe ser minimo de 6';
              },
            ), 
             const  SizedBox( height: 30 ),

             MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.lightGreen,
              child: Container(
                padding: const EdgeInsets.symmetric( horizontal: 40, vertical: 15),
                child: Text(
                  loginForm.isLoading
                  ?'Espere..'
                  :'Registrar',
                  style: const TextStyle( color: Colors.white ),
                )
                ),
              onPressed: loginForm.isLoading ? null: () async{
                FocusScope.of(context).unfocus(); 
                final authServ=Provider.of<AuthService>(context, listen: false);
                
                if(!loginForm.isValidForm()) return;

                loginForm.isLoading=true;
                
                final String? errorMes= await authServ.createrLogin(loginForm.email, loginForm.password);
                
                if(errorMes == "registro exitoso"){
                  final String? cargaUsuari=await authServ.createUsuario( loginForm.email , datosUsProvider.nombre, datosUsProvider.fecha, datosUsProvider.sexo);
                 
                 if(cargaUsuari=="registro exitoso")
                 {
                  await storage.write(key: 'inicio', value: "Creado");

                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Bienvenido")));
                  Navigator.pushReplacementNamed(context, 'home');
                 }
                }
                else{
                   ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(errorMes!)));
                   loginForm.isLoading=false;
                }
                             
              }, 
              ), 
        ],
        ),
      ),
    );
  }
}