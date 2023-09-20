import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/screens/citas_screen.dart';
import 'package:dental_care_app/presentation/widgets/button_blue.dart';
import 'package:dental_care_app/presentation/widgets/logo_image.dart';
import 'package:dental_care_app/presentation/widgets/title_subtitle.dart';
 
class NotificacionScreenScreen extends StatelessWidget {
  static const nombre = 'notificacionScreen';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
          
              LogoImage(
                height: 130
              ),

              SizedBox(height: 10,),
          
              TitleSubTitle(
                horizontal: 20,
                title: 'Notificación'
              ),
          
              BodyNotificacion(),
              
          
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
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      // color: Colors.red[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          TitleSubTitle(
            horizontal: 0,
            title: 'Cita reservada',
            subTitle: 'Paciente: Ruth R.',
          ),

          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              // color: Colors.red,
              image: DecorationImage(
                image: AssetImage('assets/images/patient-icon.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Text('Fecha: 27/09/23'),
          Text('Hora: 3pm - 4pm'),

          SizedBox(height: 20,),

          TitleSubTitle(
            horizontal: 0,
            title: 'Doctor',
          ),

          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              // color: Colors.red,
              image: DecorationImage(
                image: AssetImage('assets/images/doctor-icon.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Text('Dr. Juan M.'),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
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