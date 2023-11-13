import 'package:dental_care_app/presentation/screens/historial_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/presentation/helpers/preferences.dart';
import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    final usuarioLogeado = usuarioService.usuarioLogeado;
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;


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
        
            const SizedBox(height: 20,),
            
            ListTile(
              title: Text('${usuarioLogeado!.nombre} ${usuarioLogeado.apellidos.split(' ')[0]}' , style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
              subtitle: Text(usuario?.email ?? Preferences.correo, style: const TextStyle(fontSize: 16, color: Colors.grey)),              
            ),
        
            const SizedBox(height: 10,),
            
            if( usuarioLogeado.email != 'admin@gmail.com')
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_today_outlined, ),
                    title: const Text('Mis citas'),
                    onTap: () {
                      Navigator.pushNamed(context, CitasScreen.nombre);
                    },
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20,) ,
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.person_outline,),
                    title: const Text('Mis perfil'),
                    onTap: () {
                      Navigator.pushNamed(context, PerfilScreen.nombre);
                    },
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20,) ,
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.note_add_outlined, ),
                    title: const Text('Historial dental'),
                    onTap: () {
                      Navigator.pushNamed(context, HistorialScreen.nombre);
                    },
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20,) ,
                  ),
                  const Divider(),
                ],
              ),
            

            if( usuarioLogeado.email == 'admin@gmail.com')
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_today_outlined),
                    title: const Text('Citas programadas'),
                    onTap: () {
                      Navigator.pushNamed(context, CitasProgramadasDocScreen.nombre);
                    },
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20,) ,
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.note_add_outlined, ),
                    title: const Text('Historial dental'),
                    onTap: () {
                      Navigator.pushNamed(context, HistorialDocScreen.nombre);
                    },
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20,) ,
                  ),
                  const Divider(),
                ],
              ),
            
        
            const Spacer(),
        
            ListTile(
              leading: const Icon(Icons.logout_outlined, ),
              title: const Text('Cerrar sesión'),
              onTap: () {
                final authService = Provider.of<AuthService>(context, listen: false);
                authService.logOut();
        
                Navigator.pushReplacementNamed(context, LoginScreen.nombre);
              },
            ),
            
          ],
        ),
      ),
    );
  }
}