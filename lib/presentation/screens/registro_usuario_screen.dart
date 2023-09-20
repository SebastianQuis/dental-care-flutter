import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/widgets/input_form.dart';
import 'package:dental_care_app/presentation/widgets/button_blue.dart';
import 'package:dental_care_app/presentation/widgets/logo_image.dart';
import 'package:dental_care_app/presentation/widgets/mostrar_alerta.dart';
import 'package:dental_care_app/presentation/widgets/title_subtitle.dart';
 
class RegistroUsuarioScreen extends StatelessWidget {
  static String nombre = 'registroUser';

  const RegistroUsuarioScreen({super.key});  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              LogoImage(
                height: 220
              ),
        
              TitleSubTitle(
                subTitle: 'Parece que eres nuevo con nosotros. Crea una cuenta para completar tu experiencia!',
                title: 'Registrate',
              ),

              const SizedBox(height: 10,),

              BodyRegistro(),
        
        
            ]
          ),
        )
      ),
    );
  }
}

class BodyRegistro extends StatefulWidget {

  BodyRegistro({super.key});

  @override
  State<BodyRegistro> createState() => _BodyRegistroState();
}

class _BodyRegistroState extends State<BodyRegistro> {
  bool isSaveSesion = false;
  // FocusNode _focusNode = FocusNode();

  // @override
  // void initState() {
  //   _focusNode.requestFocus();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          
          InputForm(
            textInputType: TextInputType.name, 
            hintText: 'Nombres', 
          ),
          
          InputForm(
            textInputType: TextInputType.name, 
            hintText: 'Apellidos', 
          ),
          
          InputForm(
            textInputType: TextInputType.emailAddress, 
            hintText: 'Correo electrónico', 
          ),
          
          InputForm(
            textInputType: TextInputType.number, 
            hintText: 'Número telefónico', 
          ),
          
          InputForm(
            textInputType: TextInputType.name, 
            hintText: 'Contraseña', 
            obscureText: true,
          ),

          InputForm(
            textInputType: TextInputType.name, 
            hintText: 'Fecha de nacimiento', 
          ),

          const SizedBox(height: 10,),

          CheckboxListTile(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('He leído y acepto los '),
                Text('términos y condiciones', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline
                ),),
              ],
            ),
            value: isSaveSesion,
            onChanged: (value) {
              mostrarAlerta(context, 'Términos y condiciones',
                '''Uso personal de la aplicación.\nRespeta la privacidad y derechos de terceros.\nCuida la confidencialidad de tu cuenta.\nNo subas contenido inapropiado.\nNo ganratizamos funcionamiento perfecto.\nLeyes locales aplican.\nTérminos pueden cambiar.''', 
                [
                  MaterialButton(
                    onPressed: () {
                      isSaveSesion = value!;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    elevation: 5,
                    textColor: Colors.blue,
                    child: const Text('Ok'),
                  ),
                  
                ]
              );
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),

          const SizedBox(height: 10,),

          ButtonBlue(
            onPressed: () {
              
            }, 
            nombre: 'Registrarse'
          ),

          const SizedBox(height: 20,)

        ],
      ),
    );
  }
}