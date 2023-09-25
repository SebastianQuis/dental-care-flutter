import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/drawer/drawer_menu.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class HistorialScreen extends StatelessWidget {
  static const nombre = 'historialScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      
      drawer: DrawerMenu(),
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [

              LogoImage(
                height: 130
              ),

              SizedBox(height: 20,),

              Text('Historial dental', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),),


              SizedBox(height: 50,),

              BodyHistorial()

            ],
          ),
        )
      )
    );
  }
}


class BodyHistorial extends StatelessWidget {
  const BodyHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      child: Column(
        children: [


          TitleSubTitle(title: 'Diagnostico', subTitle: 'Extracción de muela y limpieza dental'),
          
          SizedBox(height: 20,),

          TitleSubTitle(title: 'Recomendaciones', subTitle: 'No comer en 2 horas, luego solo alimentos blandos'),

        ],
      ),
    );
  }
}