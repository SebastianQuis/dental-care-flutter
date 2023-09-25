
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/domain/entities/entities.dart';
import 'package:dental_care_app/presentation/providers/login_form_provider.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
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

              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 50,
                // color: Colors.green[100],
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  icon: Icon(Icons.arrow_back, color: Colors.black, size: 30,)
                ),
              ),


              LogoImage(
                height: 130
              ),
        
              TitleSubTitle(
                subTitle: 'Parece que eres nuevo con nosotros. Crea una cuenta para completar tu experiencia!',
                title: 'Registrate',
              ),
    
              const SizedBox(height: 10,),
    
              ChangeNotifierProvider(
                create: (context) => LoginFormProvider(),
                child: BodyRegistro()
              ),
        
        
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

  @override
  Widget build(BuildContext context) {
    final authServiceProvider = Provider.of<AuthService>(context);
    final loginForm = Provider.of<LoginFormProvider>(context);
    final usuarioService = Provider.of<UsuarioService>(context);
    
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            
            InputForm(
              textInputType: TextInputType.name, 
              hintText: 'Nombres', 
              onChanged: (value) => loginForm.nombre = value,
              validator: (value) {
                return (value != null && value.length > 2)
                  ? null
                  : 'Ingrese un nombre valido';
              },
            ),
            
            InputForm(
              textInputType: TextInputType.name, 
              hintText: 'Apellidos',
              onChanged: (value) => loginForm.apellidos = value,
              validator: (value) {
                return (value != null && value.length > 6)
                  ? null
                  : 'Ingrese un apellido valido';
              },
            ),
            
            InputForm(
              textInputType: TextInputType.emailAddress, 
              hintText: 'Correo electrónico',
              onChanged: (value) => loginForm.usuario = value,
              validator: (value) {
                String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
      
                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Ingrese un correo valido';
              },
            ),
            
            InputForm(
              textInputType: TextInputType.number, 
              hintText: 'Número telefónico',
              onChanged: (value) => loginForm.celular = value,
              validator: (value) {
                return ( value != null && value.length == 9)
                  ? null
                  : 'Ingrese un teléfono valido';
              }, 
            ),
            
            InputForm(
              textInputType: TextInputType.name, 
              hintText: 'Contraseña', 
              obscureText: true,
              onChanged: (value) => loginForm.contrasenia = value,
              validator: (value) {
                return (value != null && value.length > 5)
                  ? null
                  : 'Ingrese una contraseña valida';
              },
            ),
      
            InputForm(
              textInputType: TextInputType.name, 
              hintText: 'Fecha de nacimiento', 
              onChanged: (value) => loginForm.nacimiento = value,
              validator: (value) {
                return (value != null && value.length == 10) // 01/01/2023
                  ? null
                  : 'Patrón de fecha 01/01/2023';
              },
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
              onPressed: loginForm.isLoading
                ? null
                : () async {
                  FocusScope.of(context).unfocus();
                  if (!loginForm.isValidForm()) return;
      
                  loginForm.isLoading = true;
      
                  await Future.delayed(const Duration(seconds: 1));
      
                  loginForm.isLoading = false;

                  final newUsuario = Usuario(
                    apellidos: loginForm.apellidos!, 
                    celular: loginForm.celular!, 
                    email: loginForm.usuario, 
                    nacimiento: loginForm.nacimiento!, 
                    nombre: loginForm.nombre!, 
                    password: loginForm.contrasenia
                  );

                  print(newUsuario.toJson());

                  if (isSaveSesion) {
                    final String? token = await authServiceProvider.createUser(loginForm.usuario, loginForm.contrasenia);
                    await usuarioService.crearUsuario(newUsuario);
                    if (token == null) {
                      NotificacionService.showSnackBar('Cuenta creada', Colors.black45);
                      Navigator.pushReplacementNamed(context, LoginScreen.nombre);
                    } else {
                      NotificacionService.showSnackBar('Cuenta existente', Colors.red);
                      loginForm.isLoading = false;
                    }
                  } else {
                    NotificacionService.showSnackBar('Aceptar términos y condiciones', Colors.red);
                  }

                }, 
              nombre: loginForm.isLoading ? 'Cargando..' : 'Registrar'
            ),
      
            const SizedBox(height: 20,)
      
          ],
        ),
      ),
    );
  }
}