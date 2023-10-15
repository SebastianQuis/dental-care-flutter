import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:dental_care_app/domain/entities/usuario_entitie.dart';

class UsuarioService extends ChangeNotifier {

  final String _baseURL = 'flutter-dentalcare-default-rtdb.firebaseio.com';
                          
  Usuario? usuarioLogeado;
  bool isLoading = true;

  Future<String?> crearUsuario(Usuario usuario) async {
    try {
      isLoading = true;
      final url = Uri.https(_baseURL, 'usuario.json');
      final respuesta = await http.post(url, body: usuario.toRawJson());
      final dataDecodificada = jsonDecode(respuesta.body);

      usuario.id = dataDecodificada['name']; // name es el id del usuario que crea por defecto firebase
      isLoading = false;

      return usuario.id!;  
    } catch (e) {
      return null;
    }
    
  }

  Future<Usuario?> buscarUsuarioByCorreo(String email) async {
    try {
      final url = Uri.https(_baseURL, 'usuario.json', {
        "orderBy": '"email"',
        "equalTo": '"$email"',
      });
      final respuesta = await http.get(url);
      
      if (respuesta.statusCode == 200) {
        final dataDecodificada = jsonDecode(respuesta.body);
        final id = dataDecodificada.keys.first;
        usuarioLogeado = Usuario.fromJson(dataDecodificada[id]);
        return usuarioLogeado;
      } else {
        return null;
      } 
    } catch (e) {
      return null;
    }
  }

}