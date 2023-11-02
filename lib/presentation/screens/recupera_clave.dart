
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class RecuperaClaveScreen extends StatelessWidget {
   static String nombre = 'recuperaClave';  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                  icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30,)
                ),
              ),
        
              LogoImage(
                height: 220,
              ),
        
              Padding(
                padding: const EdgeInsets.only( top: 20, bottom: 40),
                child: TitleSubTitle(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  title: '¿Olvidaste tu contraseña?', 
                  subTitle: 'Ingresa tu correo electrónico y revisa tu correo para restablecer tu contraseña'
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
    final authService = Provider.of<AuthService>(context);

    String? _email;

    return Container(
      width: double.infinity,
      height: size.height*0.7,
      // color: Colors.red[100],
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InputForm(
            textInputType: TextInputType.emailAddress,
            hintText: 'Correo electrónico',
            onChanged: (value) => _email = value,
            // validator: (value) {
              
            // },
          ),

          const SizedBox(height: 20,),

          ButtonBlue(
            onPressed: () async {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              if (regExp.hasMatch(_email ?? '')) {
                await authService.recuperarClave(_email!);
                NotificacionService.showSnackBar('Correo enviado', Colors.black45);
              } else {
                NotificacionService.showSnackBar('Correo incorrecto', Colors.red);
              }
            }, 
            nombre: 'Verificar'
          ),
        ],
      ),
    );
  }
}