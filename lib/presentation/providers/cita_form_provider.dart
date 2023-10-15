import 'package:flutter/material.dart';

class CitaFormProvider extends ChangeNotifier {
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String fecha = '';
  String paciente = '';
  String? diagnostico;
  bool horario1 = false;
  bool horario2 = false;
  bool horario3 = false;
  String? recomendaciones;
  String? id;

  bool _isLoading = false; 
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  actualizaHorario1(bool value) {
    horario1 = value;
    horario2 = false;
    horario3 = false;
    notifyListeners();
  }

  actualizaHorario2(bool value) {
    horario2 = value;
    horario1 = false;
    horario3 = false;
    notifyListeners();
  }

  actualizaHorario3(bool value) {
    horario3 = value;
    horario1 = false;
    horario2 = false;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

}

