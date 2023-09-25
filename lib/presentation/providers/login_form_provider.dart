import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String usuario = '';
  String contrasenia = '';
  String? apellidos;
  String? celular;
  String? nacimiento;
  String? nombre;

  bool _isLoading = false; //bloqueado hasta que se inserte el usuario y contraseña
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  actualizarNumero(String value) {
    celular = value;
    notifyListeners();
  }

  actualizaCorreo(String value) {
    usuario = value;
    notifyListeners();
  }

  bool isValidForm() {
    // print(formKey.currentState?.validate());
    // print('$usuario - $contrasenia');
    //si es valido, sino false
    return formKey.currentState?.validate() ?? false;
  }

}

