import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:dental_care_app/presentation/helpers/date_to_string.dart';
import 'package:dental_care_app/presentation/providers/cita_form_provider.dart';
import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class NewCitaScreen extends StatelessWidget {
  static const nombre = 'newCitaScreen';
  const NewCitaScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    
              const PacienteDoctor(),
    
              ChangeNotifierProvider(
                create: (context) => CitaFormProvider(),
                child: CalendarHorario()
              ),
    
            ],
          ),
        )
      )
    );
  }
}

class CalendarHorario extends StatefulWidget {
  const CalendarHorario({super.key});

  @override
  State<CalendarHorario> createState() => _CalendarHorarioState();
}

class _CalendarHorarioState extends State<CalendarHorario> {
  int selectedCheckBox = -1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    final citaService = Provider.of<CitaService>(context);
    final citaForm = Provider.of<CitaFormProvider>(context);
    
    final citaSeleccionada = citaService.citaSeleccionada;
    
    Future<DateTime?> pickDate() => showDatePicker(context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: citaForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
      
            TitleSubTitle(title: 'Fecha', horizontal: 0, vertical: 10),
            
            ButtonBlue(
              onPressed: () async {
                DateTime? date = await pickDate();
                if (date == null) return;
                citaService.selectedDate = date;
                citaForm.fecha = parseDateTimeString(citaService.selectedDate!);
                citaService.citaSeleccionada?.fecha = parseDateTimeString(citaService.selectedDate!);
                setState(() {});
              }, 
              nombre: citaService.selectedDate != null 
                ? '${formatDateCalendar(citaService.selectedDate!)} ${citaService.selectedDate!.day} del ${citaService.selectedDate!.month} de ${citaService.selectedDate!.year}'
                : 'Seleccionar fecha'
            ),
      
            TitleSubTitle(title: 'Horario', horizontal: 0, vertical: 10),
      
            CheckboxListTile(
              title: const Text('3 pm a 4 pm'),
              value: selectedCheckBox == 0,
              onChanged: (value) {
                if (value != null) {
                  citaForm.actualizaHorario1(value);
                  selectedCheckBox = 0; // Deseleccionar todos los demás
                } else {
                  selectedCheckBox = -1;
                }                 
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            
            CheckboxListTile(
              title: const Text('5 pm a 6 pm'),
              value: selectedCheckBox == 1,
              onChanged: (value) {
                if (value != null) {
                  citaForm.actualizaHorario2(value);
                  selectedCheckBox = 1; // Deseleccionar todos los demás
                } else {
                  selectedCheckBox = -1;
                }          
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            
            CheckboxListTile(
              title: const Text('7 pm a 8 pm'),
              value: selectedCheckBox == 2,
              onChanged: (value) {
                if (value != null) {
                  citaForm.actualizaHorario3(value);
                  selectedCheckBox = 2; // Deseleccionar todos los demás
                } else {
                  selectedCheckBox = -1;
                }
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
      
            Container(
              padding: const EdgeInsets.symmetric( vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

            
                  SizedBox(
                    width: size.width *0.4,
                    child: ButtonBlue(
                      onPressed: (citaService.selectedDate != null && !citaService.isLoading)
                        ? () async {
                            citaForm.isLoading = true;
                            // citaForm.paciente = citaSeleccionada!.paciente;
                            citaSeleccionada!.horario1 = citaForm.horario1;
                            citaSeleccionada.horario2 = citaForm.horario2;
                            citaSeleccionada.horario3 = citaForm.horario3;
                            if (!citaForm.isValidForm()) return;
                            Navigator.pushNamed(context, MetodoPagoScreen.nombre);
                          }
                        : null,
                      nombre: 'Aceptar'
                    ),
                  ),

                  SizedBox(
                    width: size.width *0.4,
                    child: ButtonBlue(
                    onPressed: () => Navigator.pop(context), 
                    nombre: 'Regresar'
                    ),
                  ),
                ],
              ),
            )
      
          ],
        ),
      ),
    );
  }
}

class PacienteDoctor extends StatelessWidget {
  const PacienteDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    final citaSeleccionada = Provider.of<CitaService>(context).citaSeleccionada;
    
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          UserPersonal(
            icon: Icons.person_outline,
            image: 'assets/images/patient-icon.jpg',
            title: citaSeleccionada!.paciente,
          ),
          
          const UserPersonal(
            icon: Icons.troubleshoot_sharp,
            image: 'assets/images/doctor-icon.jpg',
            title: 'Marcelo Perez',
          ),

        ],
      ),
    );
  }
}

class UserPersonal extends StatelessWidget {
  final String image;
  final String title;
  final IconData icon;

  const UserPersonal({
    super.key, 
    required this.image, 
    required this.title, 
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
    
        SizedBox(
          width: size.width * 0.4,
          height: 60,
          child: ListTile(
            title: Text(title, style: const TextStyle(fontSize: 18),),
            leading: Icon(icon, color: Colors.blue,),
          ),
        ),
    
      ],
    );
  }
}