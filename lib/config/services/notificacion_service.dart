import 'package:flutter/material.dart';

class NotificacionService {
  // metodos y propiedades estaticas para utilizar en cualquier lado de la app
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();


  static showSnackBar( String message, Color color ) {

    final snackBar = SnackBar(
      content: Text( message, style: const TextStyle( 
        color: Colors.white, fontSize: 20), textAlign: TextAlign.center, ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    );

    messengerKey.currentState!.showSnackBar(snackBar);

  }
}
