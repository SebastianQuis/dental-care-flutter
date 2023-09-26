import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/domain/entities/entities.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
import 'package:dental_care_app/presentation/providers/login_form_provider.dart';



class LoginScreen extends StatelessWidget {
  static String nombre = 'login';

  const LoginScreen({super.key});  
 
  @override
  Widget build(BuildContext context) {
    // final authServiceProvider = Provider.of<AuthService>(context);
   
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
        
              LogoImage(
                height: 220,
              ),
            
              TitleSubTitle(
                subTitle: 'Hola, ¿Estás listo para sonreir?',
                title: 'Iniciar sesión',
              ),
    
              const SizedBox(height: 10,),
        
              ChangeNotifierProvider(
                create: (context) => LoginFormProvider(),
                child: const BodyLogin()
              ),
        
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
    final loginForm = Provider.of<LoginFormProvider>(context);
    final authServiceProvider = Provider.of<AuthService>(context);
    final usuarioService = Provider.of<UsuarioService>(context);

    return Container(
      width: double.infinity,
      // height: 300,
      // color: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
        
            InputForm(
              textInputType: TextInputType.emailAddress, 
              hintText: 'example@example.com', 
              labelText: 'Email',
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
              onChanged: (value) => loginForm.contrasenia = value,
              validator: (value) {
                return (value != null && value.length > 5)
                  ? null
                  : 'Ingrese una contraseña valida';
              },
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
              onPressed: loginForm.isLoading
                ? null
                : () async {
                  FocusScope.of(context).unfocus();
                  if (!loginForm.isValidForm()) return;
      
                  loginForm.isLoading = true;
      
                  await Future.delayed(const Duration(seconds: 1));
      
                  loginForm.isLoading = false;
      
                  final String? token = await authServiceProvider.login(loginForm.usuario, loginForm.contrasenia, isSaveSesion);
      
                  if (token == null) {
                    NotificacionService.showSnackBar('Bienvenido!!', Colors.black45);
                    Navigator.pushReplacementNamed(context, CitasScreen.nombre);
                  } else {
                    NotificacionService.showSnackBar('Cuenta no existe', Colors.red);
                    loginForm.isLoading = false;
                  }

                },
              nombre: 'Inicia sesión'
            ),
      
            const SizedBox(height: 10,),
      
            TextButton(
              onPressed: () {
                usuarioService.usuarioLogeado = Usuario(
                  apellidos: '', 
                  celular: '', 
                  email: '', 
                  nacimiento: '', 
                  nombre: '', 
                  password: ''
                );

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
      ),
    );
  }
}