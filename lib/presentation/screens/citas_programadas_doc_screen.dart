import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/domain/entities/entities.dart';
import 'package:dental_care_app/presentation/helpers/date_to_string.dart';
import 'package:dental_care_app/presentation/helpers/preferences.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:dental_care_app/presentation/drawer/drawer_menu.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class CitasProgramadasDocScreen extends StatelessWidget {
  static const nombre = 'citasProgramadasDocScreen';
  const CitasProgramadasDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(

      appBar: AppBar(),

      drawer: const DrawerMenu(),

      body: SafeArea(
        child: Column(
          children: [

            LogoImage(
              height: 130
            ),

            TitleSubTitle(title: 'Citas programadas', vertical: 10),

            FutureBuilder(
              future: usuarioService.buscarUsuarioByCorreo(authService.usuario?.email ?? Preferences.correo),
              builder: (context, snapshot) {
                if ( snapshot.hasError) return const Text('Cargando..'); 
                if ( !snapshot.hasData ) return const Text('Cargando..');
                usuarioService.usuarioLogeado = snapshot.data;
                return const CitasBody();
              }
            ),

          ],
        )
      ),

    );
  }
}

class CitasBody extends StatelessWidget {
  const CitasBody({super.key});

  @override
  Widget build(BuildContext context) {
    final citaService = Provider.of<CitaService>(context);

    return FutureBuilder(
      future: citaService.obtenerCitas(),
      builder: (context, snapshot) {
        if ( snapshot.hasError) return const Center(child: Text('Cargando..')); 
        if ( !snapshot.hasData ) return const Center(child: Text('Cargando..'));
        
        final filteredCitas = snapshot.data!.where((cita) {
          final citaDate = parseStringDateTime(cita.fecha!);
          return citaDate!.isAfter(citaService.now) || citaDate.isAtSameMomentAs(citaService.now);
        }).toList();

        return snapshot.data!.isEmpty
          ? const IconAndTitle(iconData: Icons.calendar_month, title: 'Proxima cita', description: 'Sin citas.')
          : ListCitas(filteredCitas);
      },
    );
  }
}


class ListCitas extends StatelessWidget {
  final List<Cita> listCitas;
  const ListCitas(this.listCitas, {super.key});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ListView.builder(
        itemCount: listCitas.length,
        itemBuilder: (BuildContext context, int index) {
          return UnaCita(listCitas[index]);
        },
      ),
    );
  }
}


class UnaCita extends StatelessWidget {
  final Cita cita;
  const UnaCita(this.cita, {super.key});

  @override
  Widget build(BuildContext context) {
    final fecha = parseStringDateTime(cita.fecha!);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('${formatDateCalendar(fecha!)} ${fecha.day} de ${fomatMonthCalendar(fecha.month.toString())}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18 ),),
          Text(cita.paciente, style: const TextStyle(fontSize: 16),),

          Text('Hora: ${cita.horario1! ? '3:00 pm - 4:00 pm' 
            : (cita.horario2! ? '5:00 pm - 6:00 pm' 
            : (cita.horario3! ? '7:00 pm - 8:00 pm' 
            : 'Ninguno'))}'
          ),

        ],
      ),
    );
  }
}