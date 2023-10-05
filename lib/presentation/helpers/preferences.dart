
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _preferences;
  static String _correo = 'sincorreo@gmail.com';
  
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String get correo => _preferences.getString('correo') ?? _correo;
  static set correo( String value) {
    _correo = value;
    _preferences.setString('correo', value);
  }
}
