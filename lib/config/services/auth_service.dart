
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthService extends ChangeNotifier{

  
  final String _baseURL = 'identitytoolkit.googleapis.com';
  final String _fireBaseToken = 'AIzaSyBFntsdZ_XENC8a4jANcgkjtfWc_yeFcGs';
  final storage = FlutterSecureStorage();
  
  bool isLoading = true;

  Future<String?> createUser( String email, String password) async {

    final Map<String, dynamic> authData = {
      'email' : email,
      'password' : password
    };

    final url = Uri.https(_baseURL, '/v1/accounts:signUp', {
      'key': _fireBaseToken,
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);


    if (decodedResp.containsKey('idToken')) {
      await storage.write(key: 'idToken', value: decodedResp['idToken']);
      // usuario = UsuarioResponse.fromJson(json.decode(resp.body)); 
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password, bool savePassword) async {
    final Map<String, dynamic> autenticacionData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseURL, 'v1/accounts:signInWithPassword', {
      'key': _fireBaseToken, 
    });

    final respuesta = await http.post(url, body: json.encode(autenticacionData));
    final Map<String, dynamic> respuestaDecodificada = json.decode(respuesta.body);

    // print(UsuarioResponse.fromJson(respuestaDecodificada));
    
    if (respuestaDecodificada.containsKey('idToken')) {
      if (savePassword == true) {
        await storage.write(key: 'idToken', value: respuestaDecodificada['idToken']);
      }
      // usuario = UsuarioResponse.fromJson(respuestaDecodificada); //T
      return null;
    } else {
      return respuestaDecodificada['error']['message'];
    }
  }

  Future<String?> recuperarClave(String email) async {

    final Map<String, dynamic> recuperarData = {
      'email': email,
      'requestType': 'PASSWORD_RESET',
    };

    final url = Uri.https(_baseURL, 'v1/accounts:sendOobCode', {
      'key': _fireBaseToken, 
    });

    final resp = await http.post(url, body: json.encode(recuperarData));
    final Map<String, dynamic> respDecodificada = jsonDecode(resp.body);

    if (respDecodificada.containsKey('email')) {
      return null;
    } else {
      return respDecodificada['error']['message'];
    }
  }

  Future logOut() async {
    await storage.delete(key: 'idToken');
    return; 
  }

  Future<String> leerToken() async {
    return await storage.read(key: 'idToken') ?? '';
  }

}