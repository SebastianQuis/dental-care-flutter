
import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/screens/screens.dart';

class AppRoutes {

  static String initialRoute = CargaScreen.nombre;
  
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
    appRoutes.addAll( { CargaScreen.nombre                 : ( _ ) => CargaScreen()});
    appRoutes.addAll( { CitaReprogramaScreen.nombre        : ( _ ) => CitaReprogramaScreen()});

    return appRoutes;
  }

}

