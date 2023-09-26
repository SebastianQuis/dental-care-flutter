
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';

 
class CargaScreen extends StatelessWidget {
  static String nombre = 'cargaScreen';
 
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.leerToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            
            if ( !snapshot.hasData ) {
              return const Text('Cargando..');
            }
            
            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___) => FadeIn(child: const LoginScreen()),
                  transitionDuration: const Duration(seconds: 1),
                ));
              });
            } else { // si tiene el idToken
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___) => FadeIn(child: CitasScreen()), 
                  transitionDuration: const Duration(seconds: 1),
                ));
              });
            }


            return Text('Cargando..');
          },
        ),
     ),
   );
  }
}