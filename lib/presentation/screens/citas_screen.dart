import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
 
import 'package:dental_care_app/domain/entities/entities.dart';
import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/presentation/helpers/date_to_string.dart';
import 'package:dental_care_app/presentation/helpers/preferences.dart';
import 'package:dental_care_app/presentation/drawer/drawer_menu.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';


class CitasScreen extends StatelessWidget {
  static const nombre = 'citasScreen';
  const CitasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    final authService = Provider.of<AuthService>(context);
    
    return Scaffold(

      appBar: AppBar(),
      
      drawer: const DrawerMenu(),
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

              LogoImage(
                height: 130
              ),

              FutureBuilder(
                future: usuarioService.buscarUsuarioByCorreo(authService.usuario?.email ?? Preferences.correo),
                builder: (context, snapshot) {
                  if ( snapshot.hasError) return const Text('Cargando..'); 
                  if ( !snapshot.hasData ) return const Text('Cargando..');
                  usuarioService.usuarioLogeado = snapshot.data;
                  return Column(
                    children: [

                      Titulo(usuario: usuarioService.usuarioLogeado!),

                      const SizedBox(height: 20,),

                      _MisCitas(usuario: usuarioService.usuarioLogeado!),
                      
                      _ProgramarCita(usuario: usuarioService.usuarioLogeado!),
                    
                      _RepogramarCita(),
                    ],
                  );
                },
              ),
            ],
          ),
        )
      )


    );
  }
}

class Titulo extends StatelessWidget {
  final Usuario usuario;
  const Titulo({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return TitleSubTitle(
      crossAxisAlignment: CrossAxisAlignment.center,
      title: 'Bienvenido',
      subTitle: '${usuario.nombre} ${usuario.apellidos}',
    );
  }
}

class _ProgramarCita extends StatelessWidget {
  final Usuario usuario;
  const _ProgramarCita({required this.usuario});

  @override
  Widget build(BuildContext context) {
    final citaService = Provider.of<CitaService>(context);

    return GestureDetector(
      onTap: () {
        final hoy = DateTime.now().toString().split(' ')[0];
        
        citaService.citaSeleccionada = Cita(
          fecha: hoy,
          paciente: '${usuario.nombre} ${usuario.apellidos}'
        );

        Navigator.pushNamed(context, NewCitaScreen.nombre);
      },
      child: const IconAndTitle(
        iconData: Icons.new_label_outlined, 
        title: 'Programar cita', 
        description: 'Selecciona la fecha y hora de tu próxima cita',
      ),
    );
  }
}

class _MisCitas extends StatelessWidget {
  final Usuario usuario;
  const _MisCitas({required this.usuario});

  @override
  Widget build(BuildContext context) {
    final citaService = Provider.of<CitaService>(context);
    final paciente = '${usuario.nombre} ${usuario.apellidos}';
  
    return FutureBuilder(
      future: citaService.obtenerCitaPorPacienteEspecifico(paciente),
      builder: (context, snapshot) {
        if ( snapshot.hasError) return const Center(child: Text('Cargando..')); 
        if ( !snapshot.hasData ) return const Center(child: Text('Cargando..'));
        
        return snapshot.data!.isEmpty
          ? const IconAndTitle(iconData: Icons.calendar_month, title: 'Proxima cita', description: 'Sin citas.')
          : MiCita(listCitas: snapshot.data!);
      },
    );
  }
}

class MiCita extends StatelessWidget {
  final List<Cita> listCitas;
  const MiCita({super.key, required this.listCitas});

  @override
  Widget build(BuildContext context) {
    final citaService = Provider.of<CitaService>(context);
    listCitas.sort((a, b) => b.fecha!.compareTo(a.fecha!));
    final newListCitas = listCitas.reversed.toList();
    Cita? cita = newListCitas.isNotEmpty ? newListCitas.last : null;
    
    if (cita != null) {
      final fecha = parseStringDateTime(cita.fecha!);
      citaService.citaReprogramar = cita;
      final horario = (cita.horario1!)
          ? '3:00 pm a 4:00 pm'
          : (cita.horario2!)
              ? '5:00 pm a 6:00 pm'
              : (cita.horario3!)
                  ? '7:00 pm a 8:00 pm'
                  : 'Sin asignar';

      return IconAndTitle(
        iconData: Icons.calendar_month,
        title: 'Próxima cita',
        description:
            'Tu cita pendiente es el ${formatDateCalendar(fecha!)} ${fecha.day} de ${fomatMonthCalendar(fecha.month.toString())} de $horario',
      );
    } else {
      return const IconAndTitle(
        iconData: Icons.calendar_month,
        title: 'Proxima cita',
        description: 'Sin citas.',
      );
    }
  }
}

// class MiCita extends StatelessWidget {
//   final List<Cita> listCitas;
//   const MiCita({super.key, required this.listCitas});

//   @override
//   Widget build(BuildContext context) {
//     final citaService = Provider.of<CitaService>(context);

//     Cita? cita = listCitas[listCitas.length - 1];
//     final fecha = parseStringDateTime(cita.fecha!);
//     citaService.citaReprogramar = cita;
//     final horario = (cita.horario1!) ? '3:00 pm a 4:00 pm' : (cita.horario2!) ? '5:00 pm a 6:00 pm' : (cita.horario3!) ? '7:00 pm a 8:00 pm' : 'Sin asignar';
    
//     return IconAndTitle(
//       iconData: Icons.calendar_month, 
//       title: 'Próxima cita', 
//       description: 'Tu cita pendiente es el ${formatDateCalendar(fecha!)} ${fecha.day} de ${fomatMonthCalendar(fecha.month.toString())} de $horario',
//     );
//   }
// }

class _RepogramarCita extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {

        Navigator.pushNamed(context, CitaHistorialReprogramaScreen.nombre);
      },
      child: const IconAndTitle(
        iconData: Icons.calendar_month_rounded, 
        title: 'Reprogramar cita', 
        description: 'Modifique la fecha de una cita registrada',
      )
    );
  }
}

class IconAndTitle extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String description;

  const IconAndTitle({
    super.key, 
    required this.iconData, 
    required this.title, 
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
    
          Icon(iconData, size: 30, color: Colors.blue,),
    
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
      
          Text(description, style: const TextStyle(fontSize: 16),),

          const SizedBox(height: 5,),
          
          const Divider(),
    
        ],
      ),
    );
  }
}