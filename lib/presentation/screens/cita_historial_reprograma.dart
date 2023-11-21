import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/domain/entities/entities.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class CitaHistorialReprogramaScreen extends StatelessWidget {
  static const nombre = 'citaReprogramaScreen';
  const CitaHistorialReprogramaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    final citaService = Provider.of<CitaService>(context);
    final paciente = '${usuarioService.usuarioLogeado!.nombre} ${usuarioService.usuarioLogeado!.apellidos}';


    return Scaffold(
      appBar: AppBar(),
      
      body: SafeArea(
        child: Column(
          children: [

            LogoImage(
              height: 130
            ),

            TitleSubTitle(
              vertical: 10,
              horizontal: 20,
              title: 'Citas',
              subTitle: 'Seleccione el registro que se desea reprogramar la fecha de la cita',
            ),

            FutureBuilder(
            future: citaService.obtenerCitsaPorPaciente(paciente),
            builder: (context, snapshot) {
              if ( snapshot.hasError) return const Text('Cargando..'); 
              if ( !snapshot.hasData ) return const Text('Cargando..');
              
              return _HistorialCitasBody(listCitas: snapshot.data!);
            },
          ),

          ],
        )
      ),
    );
  }
}


class _HistorialCitasBody extends StatelessWidget {
  final List<Cita> listCitas;
  const _HistorialCitasBody({
    required this.listCitas
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listCitas.length,
        itemBuilder: (BuildContext context, int index) {
          return _UnaCita(cita: listCitas[index], index: index,);
        },
      ),
    );
    
  }
}

class _UnaCita extends StatelessWidget {
  final Cita cita;
  final int index;

  const _UnaCita({ 
    required this.cita, 
    required this.index 
  });

  @override
  Widget build(BuildContext context) {
    final citaService = Provider.of<CitaService>(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1.0, 1.0),
            spreadRadius: 1,
            color: Colors.black54
          )
        ]
      ),
      child: ListTile(
        leading: Text('Cita ${index + 1}', style: const TextStyle(fontSize: 14),),
        title: Text('${cita.fecha}', style: const TextStyle(fontWeight: FontWeight.w600),),
        subtitle: Text((cita.horario1!) ? '3:00 pm a 4:00 pm' : (cita.horario2!) ? '5:00 pm a 6:00 pm' : (cita.horario3!) ? '7:00 pm a 8:00 pm' : 'Sin asignar'),
        trailing: const Icon(Icons.navigate_next),
        onTap: () {
          // print('${cita.id}');
          citaService.citaReprogramar = cita;
          Navigator.pushNamed(context, CitaReprogramaScreen.nombre);
        },
      ),
    );
  }
}