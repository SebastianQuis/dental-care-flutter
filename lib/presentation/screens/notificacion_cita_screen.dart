import 'package:dental_care_app/config/services/cita_service.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/presentation/screens/citas_screen.dart';
import 'package:dental_care_app/presentation/helpers/date_to_string.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class NotificacionScreenScreen extends StatelessWidget {
  static const nombre = 'notificacionScreen';
  const NotificacionScreenScreen({super.key});
  
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

              const SizedBox(height: 10,),
          
              TitleSubTitle(
                horizontal: 20,
                title: 'Notificación'
              ),
          
              const BodyNotificacion(),
          
            ],
          )
        )
      ),
    );
  }
}

class BodyNotificacion extends StatelessWidget {
  const BodyNotificacion({super.key});

  @override
  Widget build(BuildContext context) {
    // final citaForm = Provider.of<CitaFormProvider>(context);
    // DateTime? fecha = parseStringDateTime(citaForm.fecha);
    final citaSeleccionada = Provider.of<CitaService>(context).citaSeleccionada;
    

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          TitleSubTitle(
            horizontal: 0,
            title: 'Cita reservada',
            subTitle: 'Paciente: ${citaSeleccionada!.paciente}',
          ),

          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              image: DecorationImage(
                image: AssetImage('assets/images/patient-icon.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Text(formatearFecha(citaSeleccionada.fecha!), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18 ),),
          Text('Hora: ${citaSeleccionada.horario1! ? '3:00 pm - 4:00 pm' 
            : (citaSeleccionada.horario2! ? '5:00 pm - 6:00 pm' 
            : (citaSeleccionada.horario3! ? '7:00 pm - 8:00 pm' 
            : 'Ninguno'))}'),

          const SizedBox(height: 20,),

          TitleSubTitle(
            horizontal: 0,
            title: 'Doctor',
          ),

          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              // color: Colors.red,
              image: DecorationImage(
                image: AssetImage('assets/images/doctor-icon.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          const Text('Dr. Marcelo Perez'),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ButtonBlue(
              onPressed: () {
                Navigator.pushReplacementNamed(context, CitasScreen.nombre);
              }, 
              nombre: 'Terminar'
            ),
          )


        ],
      ),
    );
  }
}