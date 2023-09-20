import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/drawer/drawer_menu.dart';
import 'package:dental_care_app/presentation/widgets/button_blue.dart';
import 'package:dental_care_app/presentation/widgets/input_form.dart';
import 'package:dental_care_app/presentation/widgets/logo_image.dart';
import 'package:dental_care_app/presentation/widgets/title_subtitle.dart';
 
class PerfilScreen extends StatelessWidget {
  static const nombre = 'perfilScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      
      drawer: DrawerMenu(),
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [

              LogoImage(
                height: 130
              ),

              Cabezera(),


              Body(),

            ],
          ),
        )
      )
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green[100],
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [

          InputForm(
            labelText: 'Nombres', 
            hintText: 'Ruth Esther',
            enabled: false,
          ),
          
          InputForm(
            textInputType: TextInputType.name, 
            labelText: 'Apellidos', 
            hintText: 'Rodriguez Martinez',
            enabled: false,
          ),
          
          InputForm(
            textInputType: TextInputType.number, 
            labelText: 'Teléfono', 
            hintText: '951353739'
          ),
          
          InputForm(
            textInputType: TextInputType.emailAddress, 
            labelText: 'Correo electrónico', 
            hintText: 'ruth_r@gmail.com'
          ),

          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ButtonBlue(
              onPressed: () {
                
              }, 
              nombre: 'Actualizar'
            ),
          ),

          

        ],
      ),
    );
  }
}

class Cabezera extends StatelessWidget {
  const Cabezera({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              image: DecorationImage(
                image: AssetImage('assets/images/model.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 10,),

          TitleSubTitle(
            title: 'Mi perfil', 
            subTitle: 'Mi información',
          )

        ],
      ),
    );
  }
}