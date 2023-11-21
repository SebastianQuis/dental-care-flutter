
import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/screens/screens.dart';

import '../../presentation/screens/historial_screen.dart';

class AppRoutes {

  static String initialRoute = CargaScreen.nombre;
  
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {

    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll( { LoginScreen.nombre                   : ( _ ) => const LoginScreen()} );
    appRoutes.addAll( { RegistroUsuarioScreen.nombre         : ( _ ) => const RegistroUsuarioScreen()} );
    appRoutes.addAll( { RecuperaClaveScreen.nombre           : ( _ ) => RecuperaClaveScreen()} );
    appRoutes.addAll( { CitasScreen.nombre                   : ( _ ) => const CitasScreen()});
    appRoutes.addAll( { PerfilScreen.nombre                  : ( _ ) => const PerfilScreen()});
    appRoutes.addAll( { HistorialScreen.nombre               : ( _ ) => const HistorialScreen()});
    appRoutes.addAll( { NewCitaScreen.nombre                 : ( _ ) => const NewCitaScreen()});
    appRoutes.addAll( { MetodoPagoScreen.nombre              : ( _ ) => const MetodoPagoScreen()});
    appRoutes.addAll( { NotificacionScreenScreen.nombre      : ( _ ) => const NotificacionScreenScreen()});
    appRoutes.addAll( { CitasProgramadasDocScreen.nombre     : ( _ ) => const CitasProgramadasDocScreen()});
    appRoutes.addAll( { HistorialDocScreen.nombre            : ( _ ) => const HistorialDocScreen()});
    appRoutes.addAll( { CargaScreen.nombre                   : ( _ ) => const CargaScreen()});
    appRoutes.addAll( { CitaHistorialReprogramaScreen.nombre : ( _ ) => const CitaHistorialReprogramaScreen()});
    appRoutes.addAll( { CitaReprogramaScreen.nombre          : ( _ ) => const CitaReprogramaScreen()});

    return appRoutes;
  }

}

