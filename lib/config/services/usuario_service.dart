import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:dental_care_app/domain/entities/usuario.dart';

class UsuarioService extends ChangeNotifier {

  final String _baseURL = 'flutter-dentalcare-default-rtdb.firebaseio.com';
                          
  Usuario? usuarioLogeado;
  bool isLoading = true;

  Future<String?> crearUsuario(Usuario usuario) async {
    final url = Uri.https(_baseURL, 'usuario.json');

    final respuesta = await http.post(url, body: usuario.toRawJson());
    final dataDecodificada = jsonDecode(respuesta.body);

    usuario.id = dataDecodificada['name']; // name es el id del usuario que crea por defecto firebase

    return usuario.id!;
  }

  Future<Usuario?> buscarUsuarioByCorreo(String email) async {
    final url = Uri.https(_baseURL, 'usuario.json', {
      "orderBy": '"email"',
      "equalTo": '"$email"',
    });

    final respuesta = await http.get(url);
    
    if (respuesta.statusCode == 200) {
      final dataDecodificada = jsonDecode(respuesta.body);
      // print(dataDecodificada);
      final id = dataDecodificada.keys.first;
      usuarioLogeado = Usuario.fromJson(dataDecodificada[id]);
      return usuarioLogeado;
    } else {
      return null;
    }
  }




}