
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import 'package:dental_care_app/config/services/notificacion_service.dart';
import 'package:dental_care_app/config/services/usuario_service.dart';
import 'package:dental_care_app/config/services/auth_service.dart';
import 'package:dental_care_app/config/routes/app_routes.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';

void main() {
  runApp(const AppState());
}


class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => UsuarioService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: NotificacionService.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Dental Care App',
      home: LoginScreen(),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0XFF3d8af7),
      ),
      routes: AppRoutes.getAppRoutes(),
      initialRoute: AppRoutes.initialRoute,
    );
  }
}