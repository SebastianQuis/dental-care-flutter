import 'dart:convert';

import 'package:dental_care_app/domain/entities/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuarioService extends ChangeNotifier {

  final String _baseURL = 'flutter-dentalcare-default-rtdb.firebaseio.com';
  
  Usuario? usuarioSeleccionado;
  bool isLoading = true;

  Future<String?> crearUsuario(Usuario usuario) async {
    final url = Uri.https(_baseURL, 'usuario.json');

    final respuesta = await http.post(url, body: usuario.toRawJson());
    final dataDecodificada = jsonDecode(respuesta.body);

    usuarioSeleccionado = usuario; // TODO: GUARDAR EN SHAREDPREFERENCES.

    usuario.id = dataDecodificada['name'];

    print(dataDecodificada);

    // usuario.id = dataDecodificada['name']; // name es el id del usuario que crea por defecto firebase

    return usuario.id!;
  }

}