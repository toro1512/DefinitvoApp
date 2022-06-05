import 'package:flutter/material.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';



class ThemeProvider extends ChangeNotifier{
  
  late ThemeData currentTheme;

  ThemeProvider({
     required bool isDarkmode

  }): currentTheme=isDarkmode ? AppTheme.darkTheme: AppTheme.lightTheme;

  setLightmode(){
    currentTheme= AppTheme.lightTheme;
    notifyListeners();
  }
  setDarkmode(){
currentTheme= AppTheme.darkTheme;
    notifyListeners();

  }

}