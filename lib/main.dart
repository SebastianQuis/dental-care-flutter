import 'package:dental_care_app/config/routes/app_routes.dart';
import 'package:dental_care_app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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