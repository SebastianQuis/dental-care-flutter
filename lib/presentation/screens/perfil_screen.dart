import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/domain/entities/entities.dart';
import 'package:dental_care_app/presentation/drawer/drawer_menu.dart';
import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class PerfilScreen extends StatelessWidget {
  static const nombre = 'perfilScreen';
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      
      drawer: const DrawerMenu(),
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

              LogoImage(
                height: 130
              ),

              const Cabezera(),


              const Body(),

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
    final usuarioService = Provider.of<UsuarioService>(context);
    final authService = Provider.of<AuthService>(context);
    final usuarioLogueado = Provider.of<UsuarioService>(context).usuarioLogeado;

    print('${authService.usuario!.idToken}');

    return Container(
      // color: Colors.green[100],
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [

          InputForm(
            labelText: 'Nombres', 
            hintText: usuarioLogueado!.nombre,
            enabled: false,
          ),
          
          InputForm(
            textInputType: TextInputType.name, 
            labelText: 'Apellidos', 
            hintText: usuarioLogueado.apellidos,
            enabled: false,
          ),
          
          InputForm(
            textInputType: TextInputType.number, 
            labelText: 'Teléfono', 
            hintText: usuarioLogueado.celular,
            onChanged: (value) => usuarioLogueado.celular = value,
          ),
          
          InputForm(
            textInputType: TextInputType.emailAddress, 
            labelText: 'Correo electrónico', 
            hintText: usuarioLogueado.email,
            onChanged: (value) => usuarioLogueado.email = value,
          ),

          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ButtonBlue(
              onPressed: usuarioService.isLoading
                ? null 
                : () async {
                  
                  FocusScope.of(context).unfocus();
                  // usuarioService.isLoading = true;
                  final newUser = Usuario(
                    apellidos: usuarioLogueado.apellidos,
                    celular: usuarioLogueado.celular,
                    email: usuarioLogueado.email, 
                    nacimiento: usuarioLogueado.nacimiento, 
                    nombre: usuarioLogueado.nombre, 
                    password: usuarioLogueado.password,
                    id: usuarioLogueado.id
                  );

                  String rspt = await usuarioService.actualizarUsuario(newUser);
                  if (rspt == 'ok') {
                    NotificacionService.showSnackBar('Actualizado correctamente', Colors.black45);
                  } else {
                    NotificacionService.showSnackBar('No se pudo actualizar', Colors.redAccent);
                  }
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
          const SizedBox(height: 10,),

          TitleSubTitle(
            title: 'Mi perfil', 
            subTitle: 'Mi información',
          )

        ],
      ),
    );
  }
}