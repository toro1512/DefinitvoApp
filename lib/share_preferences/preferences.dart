import 'package:shared_preferences/shared_preferences.dart';

class Preferences{

  static late SharedPreferences _prefs;

  static  bool _isDarkmode=false;
  static  bool _primeraVez= true;
  static int _idUs=-1;
  static double _pesoUs=-1;
  static double _altuUs=-1;

  static Future init () async {
    _prefs = await SharedPreferences.getInstance();
  }


static int get idUs{
  return _prefs.getInt('idUs') ?? _idUs; 
}
static double get pesoUs{
  
  return _prefs.getDouble('pesoUs') ?? _pesoUs; 
}
static double get altuUs{
  
  return _prefs.getDouble('altuUs') ?? _altuUs; 
}


static set idUs (int value){
  _idUs=value;
  _prefs.setInt('idUs', value);
}
static set pesoUs (double value){
  _pesoUs=value;
  _prefs.setDouble('pesoUs', value);
}
static set altuUs (double value){
  _altuUs=value;
  _prefs.setDouble('altuUs', value);
}


static bool get isDarkmode{
  return _prefs.getBool('isDarkmode') ?? _isDarkmode; 
}

static set isDarkmode (bool value){
  _isDarkmode=value;
  _prefs.setBool('isDarkmode', value);
}

static bool get primeraVez{
  return _prefs.getBool('primeraVez') ?? _primeraVez; 
}

static set primeraVez(bool value){
  _primeraVez=value;
  _prefs.setBool('primeraVez', value);
}

}