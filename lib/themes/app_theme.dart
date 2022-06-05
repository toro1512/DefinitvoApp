import 'package:flutter/material.dart';


class AppTheme{
 
 static const Color primary = Color.fromRGBO(234, 24, 77, 1);

 static final ThemeData lightTheme = ThemeData.light().copyWith(
    
    primaryColor: const Color.fromRGBO(234, 24, 77, 1),

    appBarTheme: const AppBarTheme(
      toolbarHeight:45,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      color: primary,
      elevation:0
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 8,
      selectedItemColor: Colors.black,
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
        opacity: 1),
      
      backgroundColor:  Colors.black,
      unselectedItemColor:  Colors.black,
      selectedIconTheme: IconThemeData(
        color: Colors.black,
        opacity: 1,

      ),

    ),

 );
 static final ThemeData darkTheme = ThemeData.dark().copyWith(
    
    primaryColor: const Color.fromRGBO(234, 24, 77, 1),
    
    appBarTheme: const AppBarTheme(
      toolbarHeight: 60,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      color: primary,
      elevation:0
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.black,
      
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
        opacity: 1),
      
      backgroundColor:  Colors.white,
      unselectedItemColor:  Colors.black,
      selectedIconTheme: IconThemeData(
        color: Colors.black,
        opacity: 1,

      ),

    ),

 );

}