import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:dental_care_app/presentation/helpers/date_to_string.dart';
import 'package:dental_care_app/domain/entities/cita_entitie.dart';

class CitaService extends ChangeNotifier {

  final String _baseURL = 'flutter-dentalcare-default-rtdb.firebaseio.com';
  Cita? citaSeleccionada;
  Cita? citaReprogramar;
  DateTime? selectedDate;
  bool isLoading = false;

  final now = DateTime.now();

  Future<String?> crearCita(Cita cita) async {
    try {

      
      isLoading = true;
      final url = Uri.https(_baseURL, 'citas.json');
      final rspta = await http.post(url, body: cita.toRawJson());
      final dataDecodificada = jsonDecode(rspta.body);

      cita.id = dataDecodificada['name']; // name es el id del usuario que crea por defecto firebase
      isLoading = false;

      return cita.id!;  
    } catch (e) {
      return null;
    }
  }

  Future<List<Cita>> obtenerCitaPorPacienteEspecifico(String paciente) async {
    try {
      final url = Uri.https(_baseURL, 'citas.json',{
        "orderBy": '"paciente"',
        "equalTo": '"$paciente"',
      });

      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        final data = json.decode(respuesta.body);
        final listCita = convertirMapaACitas(data);
        return listCita;
      } else {
        return [];
      }
    } catch (e) {
      return  [];
    }
  }
  
  Future<List<Cita>> obtenerCitsaPorPaciente(String paciente) async {
    try {
      final url = Uri.https(_baseURL, 'citas.json',{
        "orderBy" : '"paciente"',
        "startAt" : '"$paciente"',
        "endAt"   : '"$paciente\uf8ff"',
      });

      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        final data = json.decode(respuesta.body);
        final listCita = convertirMapaACitas(data);
        return listCita;
      } else {
        return [];
      }
    } catch (e) {
      return  [];
    }
  }

  Future<String> actualizarCita(Cita cita) async {
    try {
      isLoading = true;
      final url = Uri.https(_baseURL,'citas/${cita.id}.json');
      final respuesta = await http.put(url, body: cita.toRawJson());
      // final dataDecodificada = jsonDecode(respuesta.body);
      isLoading = false;
      return 'ok';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Cita>> obtenerCitas() async {
    try {
      final url = Uri.https(_baseURL, 'citas.json');
      final respuesta = await http.get(url);
      
      if (respuesta.statusCode == 200) {
        final data = json.decode(respuesta.body);
        final listCita = convertirMapaACitas(data);
        return listCita;
      } else {
        return [];
      }
    } catch (e) {
      return  [];
    }
  }

}
