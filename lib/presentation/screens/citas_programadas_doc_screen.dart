import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/drawer/drawer_menu.dart';
import 'package:dental_care_app/presentation/widgets/logo_image.dart';
import 'package:dental_care_app/presentation/widgets/title_subtitle.dart';
 
class CitasProgramadasDocScreen extends StatelessWidget {
  static const nombre = 'citasProgramadasDocScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      drawer: DrawerMenu(),

      body: SafeArea(
        child: Column(
          children: [

            LogoImage(
              height: 130
            ),

            TitleSubTitle(title: 'Citas programadas'),

            CitasBody()

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
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return UnaCita();
        },
        itemCount: 4,
      ),
    );
  }
}

class UnaCita extends StatelessWidget {
  const UnaCita({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('Lunes', style: TextStyle(fontWeight: FontWeight.w800, ),),
          Text('Pacientes'),

          Text(' - Rut R. 3pm - 4pm'),
          Text(' - Pablo P. 3pm - 4pm'),

        ],
      ),
    );
  }
}