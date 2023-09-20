import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/screens/citas_programadas_doc_screen.dart';
import 'package:dental_care_app/presentation/screens/citas_screen.dart';
import 'package:dental_care_app/presentation/screens/historial_doc_screen.dart';
import 'package:dental_care_app/presentation/screens/historial_screen.dart';
import 'package:dental_care_app/presentation/screens/login_screen.dart';
import 'package:dental_care_app/presentation/screens/perfil_screen.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
      
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(
                  image: AssetImage('assets/images/model.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            SizedBox(height: 20,),
      
            ListTile(
              title: Text('Ruth R.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
              subtitle: Text('ruth_r@gmail.com', style: TextStyle(fontSize: 16, color: Colors.grey)),              
            ),

            SizedBox(height: 20,),
            

            ListTile(
              leading: const Icon(Icons.calendar_today_outlined, ),
              title: const Text('Mis citas'),
              onTap: () {
                Navigator.pushNamed(context, CitasScreen.nombre);
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20,) ,
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.person_outline,),
              title: const Text('Mis perfil'),
              onTap: () {
                Navigator.pushNamed(context, PerfilScreen.nombre);
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20,) ,
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.note_add_outlined, ),
              title: const Text('Historial dental'),
              onTap: () {
                Navigator.pushNamed(context, HistorialScreen.nombre);
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20,) ,
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.calendar_today_outlined),
              title: const Text('Citas programadas'),
              onTap: () {
                Navigator.pushNamed(context, CitasProgramadasDocScreen.nombre);
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20,) ,
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.note_add_outlined, ),
              title: const Text('Historial dental'),
              onTap: () {
                Navigator.pushNamed(context, HistorialDocScreen.nombre);
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20,) ,
            ),
            Divider(),

            Spacer(),

            ListTile(
              leading: const Icon(Icons.logout_outlined, ),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginScreen.nombre);
              },
            ),
      
          ],
        ),
      ),
    );
  }
}