import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/screens/citas_screen.dart';
import 'package:dental_care_app/presentation/screens/recupera_clave.dart';
import 'package:dental_care_app/presentation/screens/registro_usuario_screen.dart';
import 'package:dental_care_app/presentation/widgets/button_blue.dart';
import 'package:dental_care_app/presentation/widgets/input_form.dart';
import 'package:dental_care_app/presentation/widgets/logo_image.dart';
import 'package:dental_care_app/presentation/widgets/title_subtitle.dart';
 
class LoginScreen extends StatelessWidget {
  static String nombre = 'login';

  const LoginScreen({super.key});  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
        
              LogoImage(
                height: 220,
              ),
            
              TitleSubTitle(
                subTitle: 'Hola, ¿Estás listo para sonreir?',
                title: 'Iniciar sesión',
              ),

              SizedBox(height: 10,),
        
              BodyLogin(),
        
            ],
          ),
        ) 
      )
    );
  }
}





class BodyLogin extends StatefulWidget {
  const BodyLogin({super.key});

  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  bool isSaveSesion = false;
  bool _obscureText = true;
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
      // height: 300,
      // color: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
      
          InputForm(
            textInputType: TextInputType.emailAddress, 
            hintText: 'example@example.com', 
            labelText: 'Email'
          ),
          
          TextFormField(
            obscureText: _obscureText,
            // focusNode: _focusNode,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: '*****',
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.blue),
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                }, 
                icon: Icon( _obscureText ? Icons.visibility : Icons.visibility_off)
              ),
            ),
          ),


          CheckboxListTile(
            // activeColor: AppTheme.primary,
            title: const Text('Recordar sesión'),
            value: isSaveSesion,
            onChanged: (value) {
              isSaveSesion = value!;
              setState(() {});
              
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),

          const SizedBox(height: 10,),

          ButtonBlue(
            onPressed: (){
              Navigator.pushReplacementNamed(context, CitasScreen.nombre);
            }, 
            nombre: 'Inicia sesión'
          ),

          const SizedBox(height: 10,),

          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RegistroUsuarioScreen.nombre);
            }, 
            child: const Text('Regístrate')
          ),

          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RecuperaClaveScreen.nombre);
            }, 
            child: const Text('¿Olvidaste tu contraseña?', style: TextStyle(color: Colors.grey),)
          ),
      
        ],
      ),
    );
  }
}