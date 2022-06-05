import 'package:flutter/material.dart';
import 'package:nutri_saludapp/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomBottomNavigation extends StatelessWidget {

  
  const CustomBottomNavigation({Key? key, }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

    final generalProvider= Provider.of<GeneralProvider>(context);
    final currentIndexBo =generalProvider.indexBottom;
    return BottomNavigationBar(
      elevation: 30,
      onTap: (int i)=>generalProvider.indexBottom=i,
      currentIndex: currentIndexBo,
      type: BottomNavigationBarType.fixed,
      items:  [
        
        BottomNavigationBarItem(          
          
          icon: SvgPicture.asset("assets/HOME.svg",
          height: 30,
          width: 30,
          ),//Icon(Icons.home_max_outlined ),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/FAV.svg",height: 30,width: 30),
          label: 'Recomendaciones'
        ),
         BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/POLL.svg",height: 30,width: 30,),
          label: 'Estadisticas'
        ),
       
      ],
    );
  }
}