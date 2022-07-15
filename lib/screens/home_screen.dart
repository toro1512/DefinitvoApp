import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:nutri_saludapp/screens/screens.dart';
import 'package:nutri_saludapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeScreenBody(),
      bottomNavigationBar: const  CustomBottomNavigation(),
    );
  }
}
class _HomeScreenBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final generalProvider = Provider.of<GeneralProvider>(context);
    
    // Cambiar para mostrar la pagina respectiva
    final currentIndex = generalProvider.indexBottom;

    
    switch( currentIndex ) {

      case 0:
        return const PrincipalScreen();

      case 1: 
         return const  ValoresPersonalesScreen();
  
      case 2: 
         return const  ValoresScreen();

      default:
        return const  ValoresScreen();
    }


  }
}