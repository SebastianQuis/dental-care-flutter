
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/presentation/helpers/preferences.dart';
import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/config/routes/app_routes.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
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