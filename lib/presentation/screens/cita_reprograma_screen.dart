
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/domain/entities/entities.dart';
import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:dental_care_app/presentation/helpers/date_to_string.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';

 
class CitaReprogramaScreen extends StatelessWidget {
  static const nombre = 'reprogramaScreen';
  const CitaReprogramaScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final citaReprogramar = Provider.of<CitaService>(context).citaReprogramar;

    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
          
              LogoImage(
                height: 130
              ),

              const SizedBox(height: 10,),
          
              TitleSubTitle(
                horizontal: 20,
                title: 'Reprogramación de cita',
                subTitle: 'Modifica la fecha y hora de tu última cita registrada',
              ),
          
              _BodyReprogramacion(cita: citaReprogramar!),              
          
            ],
          )
        )
      ),
    );
  }
}


class _BodyReprogramacion extends StatefulWidget {
  final Cita cita;
  const _BodyReprogramacion({required this.cita});

  @override
  State<_BodyReprogramacion> createState() => _BodyReprogramacionState();
}

class _BodyReprogramacionState extends State<_BodyReprogramacion> {
  int selectedCheckBox = -1;
  
  @override
  Widget build(BuildContext context) {
    DateTime? fechaInicial = parseStringDateTime(widget.cita.fecha!);
    final citaService = Provider.of<CitaService>(context);
    
    Future<DateTime?> pickDate() => showDatePicker(context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [

          TitleSubTitle(
            vertical: 10,
            horizontal: 0,
            title: 'Selecciona dia a reprogramar',
            subTitle: 'Actualiza la fecha de tu última cita',
          ),
    
          ButtonBlue(
            onPressed: () async {
              DateTime? date = await pickDate();
              if (date == null) return;
              citaService.selectedDate = date;
              widget.cita.fecha = parseDateTimeString(citaService.selectedDate!);
              setState(() {});
            },
            nombre: '${formatDateCalendar(fechaInicial!)} ${fechaInicial.day} del ${fechaInicial.month} de ${fechaInicial.year}'
            // nombre: citaService.selectedDate != null 
            //   ? '${formatDateCalendar(citaService.selectedDate!)} ${citaService.selectedDate!.day} del ${citaService.selectedDate!.month} de ${citaService.selectedDate!.year}'
            //   : '${formatDateCalendar(fechaInicial!)} ${fechaInicial.day} del ${fechaInicial.month} de ${fechaInicial.year}'
          ),

          TitleSubTitle(title: 'Horario', horizontal: 0, vertical: 20),

          CheckboxListTile(
              enabled: !widget.cita.horario1!,
              title: const Text('3 pm a 4 pm'),
              value: selectedCheckBox == 0,
              onChanged: (value) {
                if (value != null) {
                  widget.cita.horario1 = value;
                  widget.cita.horario2 = false;
                  widget.cita.horario3 = false;
                  selectedCheckBox = 0; // Deseleccionar todos los demás
                } else {
                  selectedCheckBox = -1;
                }                 
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            
            CheckboxListTile(
              enabled: !widget.cita.horario2!,
              title: const Text('5 pm a 6 pm'),
              value: selectedCheckBox == 1,
              onChanged: (value) {
                if (value != null) {
                  widget.cita.horario1 = false;
                  widget.cita.horario2 = value;
                  widget.cita.horario3 = false;
                  selectedCheckBox = 1; // Deseleccionar todos los demás
                } else {
                  selectedCheckBox = -1;
                }          
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            
            CheckboxListTile(
              enabled: !widget.cita.horario3!,
              title: const Text('7 pm a 8 pm'),
              value: selectedCheckBox == 2,
              onChanged: (value) {
                if (value != null) {
                  widget.cita.horario1 = false;
                  widget.cita.horario2 = false;
                  widget.cita.horario3 = value;
                  selectedCheckBox = 2; // Deseleccionar todos los demás
                } else {
                  selectedCheckBox = -1;
                }
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),

            const SizedBox(height: 10),

            ButtonBlue(
              onPressed: (citaService.selectedDate != null && !citaService.isLoading )
                ? () async {
                  final newCita = Cita(
                    id: widget.cita.id,
                    fecha   : widget.cita.fecha, 
                    paciente: widget.cita.paciente,
                    horario1: widget.cita.horario1,
                    horario2: widget.cita.horario2,
                    horario3: widget.cita.horario3,
                    diagnostico: 'xx',
                    recomendaciones: 'xx',
                  );

                  String rspt = await citaService.actualizarCita(newCita);
                  if (rspt == 'ok') {
                    // ignore: use_build_context_synchronously
                    mostrarAlerta( context, 'Mensaje', '${widget.cita.paciente}, tu reserva se actualizó con éxito', 
                      [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, CitasScreen.nombre);
                          },
                          elevation: 5,
                          textColor: Colors.blue,
                          child: const Text('Ok'),
                        ),
                      ]
                    );
                  }
                }
                : null, 
              nombre: 'Reprogramar cita'
            )
    
        ],
      ),
    );
  }
}