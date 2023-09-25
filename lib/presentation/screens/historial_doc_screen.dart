import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/drawer/drawer_menu.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class HistorialDocScreen extends StatelessWidget {
  static const nombre = 'historialDocScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.search, color: Colors.blue,)
          ),
        ],
      ),

      
      drawer: DrawerMenu(),
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              
              LogoImage(height: 130),
              
              TitleSubTitle(
                vertical: 10,
                title: 'Paciente',
                subTitle: 'Buscar paciente..',
              ),
              
              TitleSubTitle(title: 'Historial dental', vertical: 10,),
              
              UnaHistoria(),
              
            ],
          ),
        )
      ),


    );
  }
}


class UnaHistoria extends StatelessWidget {
  UnaHistoria({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: 230,
      margin: EdgeInsets.symmetric(horizontal: 10,),
      child: Column(
        children: [

          TitleSubTitle(title: 'Última cita', horizontal: 0,),

          InputForm(
            textInputType: TextInputType.name,
            hintText: 'Extracción de muela y limpieza dental',
            labelText: 'Diagnóstico',
          ),
          
          InputForm(
            textInputType: TextInputType.name,
            hintText: 'No comer en 2 horas y solo comidas blandas',
            labelText: 'Recomendación',
          ),

          SizedBox(height: 5,),

          ButtonBlue(
            onPressed: () {
              
            }, 
            nombre: 'Actualizar historial',
          )

        ],
      ),
    );
  }
}