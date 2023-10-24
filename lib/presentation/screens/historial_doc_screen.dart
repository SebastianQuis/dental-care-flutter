import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/config/services/notificacion_service.dart';
import 'package:dental_care_app/config/services/cita_service.dart';
import 'package:dental_care_app/domain/entities/entities.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:dental_care_app/presentation/helpers/cita_search_delegate.dart';
import 'package:dental_care_app/presentation/drawer/drawer_menu.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class HistorialDocScreen extends StatefulWidget {
  static const nombre = 'historialDocScreen';
  const HistorialDocScreen({super.key});

  @override
  State<HistorialDocScreen> createState() => _HistorialDocScreenState();
}

class _HistorialDocScreenState extends State<HistorialDocScreen> {
  
  Cita? citaSeleccionada;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final cita = await showSearch(context: context, delegate: CitaSearchDelegate('Buscar..'));
              setState(() {
                citaSeleccionada = cita;
              });

            }, 
            icon: const Icon(Icons.search, color: Colors.blue,)
          ),
        ],
      ),

      
      drawer: const DrawerMenu(),
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              
              LogoImage(height: 130),

              const SizedBox(height: 10,),
              
              TitleSubTitle(
                vertical: 10,
                title: 'Registrar historia',
                subTitle: 'Busca al paciente en el icono superior derecho y registra su diagnóstico y recomendación',
              ),
              
              if( citaSeleccionada != null)
                UnaHistoria(citaSeleccionada!)
            ],
          ),
        )
      ),


    );
  }
}


class UnaHistoria extends StatelessWidget {
  final Cita cita;
  const UnaHistoria( this.cita, {super.key} );

  @override
  Widget build(BuildContext context) {
    final citaService = Provider.of<CitaService>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
      
          TitleSubTitle(title: 'Cita', subTitle: 'Última cita registrada de ${cita.paciente}', horizontal: 0,),

          InputForm(
            textInputType: TextInputType.name,
            hintText: cita.diagnostico, 
            labelText: 'Diagnóstico',
            onChanged: (value) => cita.diagnostico = value,
            validator: (value) {
              return (value != null && value.length > 2)
                  ? null
                  : 'Ingrese un diagnóstico valido';
            },
          ),
          
          InputForm(
            textInputType: TextInputType.name,
            hintText: cita.recomendaciones, 
            labelText: 'Recomendaciones',
            onChanged: (value) => cita.recomendaciones = value,
            validator: (value) {
              return (value != null && value.length > 2)
                  ? null
                  : 'Ingrese una recomendación valida';
            },
          ),
      
          const SizedBox(height: 10,),
      
          ButtonBlue(
            onPressed:  citaService.isLoading
              ? null
              : () async {
                if (cita.diagnostico!.isEmpty || cita.recomendaciones!.isEmpty ) {
                  NotificacionService.showSnackBar('Datos invalidos', Colors.red);
                }

                FocusScope.of(context).unfocus();
                final resp = await citaService.actualizarCita(cita);
                if (resp == 'ok') {
                  mostrarAlerta( context, 'Mensaje', 'Se actualizó correctamente la cita de ${cita.paciente}', 
                      [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, CitasProgramadasDocScreen.nombre);
                          },
                          elevation: 5,
                          textColor: Colors.blue,
                          child: const Text('Ok'),
                        ),
                      ]
                    );
                } else {
                  NotificacionService.showSnackBar('Hablar con admin', Colors.red);
                }
            }, 
            nombre: 'Actualizar historial',
          )
      
        ],
      ),
    );
  }
}