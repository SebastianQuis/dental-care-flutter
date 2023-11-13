import 'package:dental_care_app/domain/entities/cita_entitie.dart';
import 'package:dental_care_app/presentation/helpers/date_to_string.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/presentation/drawer/drawer_menu.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class HistorialScreen extends StatelessWidget {
  static const nombre = 'historialScreen';
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    final citaService = Provider.of<CitaService>(context);
    final paciente = '${usuarioService.usuarioLogeado!.nombre} ${usuarioService.usuarioLogeado!.apellidos}';


    return Scaffold(
      appBar: AppBar(),
      
      drawer: const DrawerMenu(),
      
      body: SafeArea(
        child: Column(
          children: [

            LogoImage(
              height: 130
            ),

            const SizedBox(height: 20,),

            const Text('Historial dental', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),),

            const SizedBox(height: 20,),

            FutureBuilder(
              future: citaService.obtenerCitsaPorPaciente(paciente),
              builder: (context, snapshot) {
                if ( snapshot.hasError) return const Text('Cargando..'); 
                if ( !snapshot.hasData ) return const Text('Cargando..');
                
                return BodyHistorial(listCitas: snapshot.data!);
              },
            ),
            // BodyHistorial()

          ],
        )
      )
    );
  }
}

class BodyHistorial extends StatelessWidget {
  final List<Cita> listCitas;
  const BodyHistorial({super.key, required this.listCitas});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listCitas.length,
        itemBuilder: (context, index) => UnaCita(cita: listCitas[index])
        ,
      ),
    );
  }
}


class UnaCita extends StatelessWidget {
  final Cita cita;
  const UnaCita({super.key, required this.cita});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(offset: Offset(0.8, 0.8))
        ]
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          TitleSubTitle(title: 'Cita', horizontal: 0,),
          Text(formatearFecha(cita.fecha!), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w800, fontSize: 16),),
          
          Text('Recomendaciones: ${cita.recomendaciones!.isEmpty ? 'sin recomendaciones' : '${cita.recomendaciones}' }'),
          Text('Diagnóstico: ${cita.diagnostico!.isEmpty ? 'sin diagnóstico' : '${cita.diagnostico}' }'),

        ],
      ),
    );
  }
}