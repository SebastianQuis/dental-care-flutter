import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/widgets/button_blue.dart';
import 'package:dental_care_app/presentation/widgets/input_form.dart';
import 'package:dental_care_app/presentation/widgets/title_subtitle.dart';
 
class RecuperaClaveScreen extends StatelessWidget {
   static String nombre = 'recuperaClave';  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 70,
                // color: Colors.green[100],
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  icon: Icon(Icons.arrow_back, color: Colors.black, size: 30,)
                ),
              ),

              Padding(
                padding: EdgeInsets.only( top: 10, bottom: 40),
                child: TitleSubTitle(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  title: '¿Olvidaste tu contraseña?', 
                  subTitle: 'Ingresa tu correo electrónico y envía el código de verificación'
                ),
              ),

              _Body(),



            ],
          ),
        ),
      )
    );
  }
}

class _Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height*0.7,
      // color: Colors.red[100],
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InputForm(
            hintText: 'Correo electrónico'
          ),

          ButtonBlue(
            onPressed: () {
              
            }, 
            nombre: 'Verificar'
          ),

          SizedBox(height: 40,),

          InputForm(
            hintText: '****',
            labelText: 'Ingresa el código de verificación'
          ),

          Row(
            children: [
              Text('¿No recibiste el código?   '),
              // SizedBox(width: 10,),
              GestureDetector(
                child: Text('Reenviar el código', style: TextStyle(fontWeight: FontWeight.w600),)),
            ],
          ),

          SizedBox(height: 40,),

          ButtonBlue(
            onPressed: () {
              
            }, 
            nombre: 'Confirmar'
          )
        ],
      ),
    );
  }
}