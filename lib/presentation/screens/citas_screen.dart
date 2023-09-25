import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
 
import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/presentation/drawer/drawer_menu.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';

class CitasScreen extends StatelessWidget {
  static const nombre = 'citasScreen';

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    
    return Scaffold(

      appBar: AppBar(),
      
      drawer: DrawerMenu(),
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [

              LogoImage(
                height: 130
              ),

              TitleSubTitle(
                crossAxisAlignment: CrossAxisAlignment.center,
                title: 'Bienvenido', 
                subTitle: '${usuarioService.usuarioSeleccionado!.nombre} ${usuarioService.usuarioSeleccionado!.apellidos}'
              ),

              SizedBox(height: 40,),

              _MisCitas(),

              Divider(),

              // SizedBox(height: 20,),
              
              _ProgramarCita(),

              // _ReprogramarCita(),

            ],
          ),
        )
      )


    );
  }
}

class _ProgramarCita extends StatelessWidget {
  const _ProgramarCita({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, NewCitaScreen.nombre);
      },
      child: Container(
        // color: Colors.red,
        child: Column(
          children: [
            IconAndTitle(
              iconData: Icons.new_label_outlined, 
              title: 'Programar cita'
            )
          ],
        ),
      ),
    );
  }
}

class _MisCitas extends StatelessWidget {
  const _MisCitas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconAndTitle(iconData: Icons.calendar_month, title: 'Mis citas'),

          Text('Ultima cita programa, doctor, hora, cita, fecha')
      ]),
    );
  }
}

class IconAndTitle extends StatelessWidget {
  final IconData iconData;
  final String title;

  const IconAndTitle({super.key, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          Icon(iconData, size: 40, color: Colors.blue,),

          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
  
          Text('Selecciona la fecha y hora de tu próxima cita'),

        ],
      ),
    );
  }
}