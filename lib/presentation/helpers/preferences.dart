
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _preferences;

  // static bool _esModoOscuro = false;
  static String _correo = 'sincorreo@gmail.com';
  
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // static bool get esModoOscuro => _preferences.getBool('esModoOscuro') ?? _esModoOscuro;

  // static set esModoOscuro(bool value) {
  //   _esModoOscuro = value;
  //   _preferences.setBool('esModoOscuro', value);
  // }

  static String get correo => _preferences.getString('correo') ?? _correo;

  static set correo( String value) {
    _correo = value;
    _preferences.setString('correo', value);
  }
}
