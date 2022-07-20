import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/screens/screens.dart';
import 'package:nutri_saludapp/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

import 'services/services.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  runApp(const AppState());
}
class AppState extends StatelessWidget {
  const AppState({ Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,

      ]); 
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>AuthService()),
      ChangeNotifierProvider(create: (_)=>GeneralProvider()),
      ChangeNotifierProvider(create: (_)=>AlimentosService()),
      ChangeNotifierProvider(create: (_)=>MedidasService()),
      ChangeNotifierProvider(create: (_)=>FisicasService()),
      ChangeNotifierProvider(create: (_)=>DatosUserProvider()),
      ChangeNotifierProvider(create: (_)=>AlimentosDayService()),
      ChangeNotifierProvider(create: (_)=>ActividadesProvider()),
     
          
    ],
    child: const Myapp(),
    );
  }
}
class Myapp extends StatelessWidget{
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
     return  MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      initialRoute: 'checking',
      routes: {
        'home':( _ ) => const HomeScreen(),
        'login': ( _ ) => const LoginScreen(),
        'setting':( _ ) => const SettingsScreen(),
        'registro':( _ ) => const RegistroScreen(),
        'checking':( _ )=> const CheckAuthScreen(),
        'alimentos':( _ )=> const AlimentosScreen(),
        'datosPersonales':( _ )=> const DatosPersonalesScreen(),
        'bienvenida':( _ )=> const BienvenidaScreen(),
        'datosDos':( _ )=> const DatosDosScreen(),
        'datosTres':( _ )=> const DatosTresScreen(),
        'glucosa':( _ )=> const TensionScreen(),
        'tension':( _ )=> const GlucosaScreen(),
        'actividades':( _ )=> const ActividadesScreen(),
        'actividadesDetalles':( _ )=> const ActividadesDetallesScreen(),
      },
      

    );
  }

}