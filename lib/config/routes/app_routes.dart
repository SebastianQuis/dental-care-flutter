
import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/screens/citas_programadas_doc_screen.dart';
import 'package:dental_care_app/presentation/screens/citas_screen.dart';
import 'package:dental_care_app/presentation/screens/historial_doc_screen.dart';
import 'package:dental_care_app/presentation/screens/historial_screen.dart';
import 'package:dental_care_app/presentation/screens/metodo_pago_screen.dart';
import 'package:dental_care_app/presentation/screens/new_cita_screen.dart';
import 'package:dental_care_app/presentation/screens/notificacion_cita_screen.dart';
import 'package:dental_care_app/presentation/screens/perfil_screen.dart';
import 'package:dental_care_app/presentation/screens/recupera_clave.dart';
import 'package:dental_care_app/presentation/screens/registro_usuario_screen.dart';
import 'package:dental_care_app/presentation/screens/login_screen.dart';


class AppRoutes {

  static String initialRoute = CitasProgramadasDocScreen.nombre;

  
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {

    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll( { LoginScreen.nombre                 : ( _ ) => LoginScreen()} );
    appRoutes.addAll( { RegistroUsuarioScreen.nombre       : ( _ ) => RegistroUsuarioScreen()} );
    appRoutes.addAll( { RecuperaClaveScreen.nombre         : ( _ ) => RecuperaClaveScreen()} );
    appRoutes.addAll( { CitasScreen.nombre                 : ( _ ) => CitasScreen()});
    appRoutes.addAll( { PerfilScreen.nombre                : ( _ ) => PerfilScreen()});
    appRoutes.addAll( { HistorialScreen.nombre             : ( _ ) => HistorialScreen()});
    appRoutes.addAll( { NewCitaScreen.nombre               : ( _ ) => NewCitaScreen()});
    appRoutes.addAll( { MetodoPagoScreen.nombre            : ( _ ) => MetodoPagoScreen()});
    appRoutes.addAll( { NotificacionScreenScreen.nombre    : ( _ ) => NotificacionScreenScreen()});
    appRoutes.addAll( { CitasProgramadasDocScreen.nombre   : ( _ ) => CitasProgramadasDocScreen()});
    appRoutes.addAll( { HistorialDocScreen.nombre          : ( _ ) => HistorialDocScreen()});

    return appRoutes;
  }

}

