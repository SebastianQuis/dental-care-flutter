
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/domain/entities/entities.dart';
import 'package:dental_care_app/config/services/services.dart';
import 'package:dental_care_app/presentation/providers/providers.dart';
import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class MetodoPagoScreen extends StatelessWidget {
  static const nombre = 'metodoPagoScreen';
  const MetodoPagoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          
              TitleSubTitle(
                crossAxisAlignment: CrossAxisAlignment.center,
                title: 'Método de pago', 
                subTitle: '¿Qué método de pago desea usar?'
              ),

              const SizedBox(height: 40,),
          
              TipoPago(),
          
          
            ],
          ),
        )
      ),
    );
  }
}


class TipoPago extends StatefulWidget {
  const TipoPago({super.key});

  @override
  State<TipoPago> createState() => _TipoPagoState();
}

class _TipoPagoState extends State<TipoPago> {
  int selectedCheckBox = -1;
  
  @override
  Widget build(BuildContext context) {
    // final citaForm = Provider.of<CitaFormProvider>(context);
    final citaService = Provider.of<CitaService>(context);
    final citaSeleccionada = citaService.citaSeleccionada;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          CheckboxListTile(
            title: const _ImageTitlePago(
              image: 'assets/images/visa-logo.png',
              title: 'Pago de tarjeta',
            ),
            value: selectedCheckBox == 0,
            onChanged: (value) {
              selectedCheckBox = 0;
              setState(() {});
            },
          ),
          
          CheckboxListTile(
            title: const _ImageTitlePago(
              image: 'assets/images/yape-logo.png',
              title: 'Yape',
            ),
            value: selectedCheckBox == 1,
            onChanged: (value) {
              selectedCheckBox = 1;
              setState(() {});
            },
          ),
          
          CheckboxListTile(
            title: const _ImageTitlePago(
              image: 'assets/images/plin-logo.png',
              title: 'Plin',
            ),
            value: selectedCheckBox == 2,
            onChanged: (value) {
              selectedCheckBox = 2;
              setState(() {});
            },
          ),

          const SizedBox(height: 40,),

          // ButtonBlue(
          //   onPressed: () {
          //     print(citaSeleccionada!.fecha);
          //     print(citaSeleccionada.paciente);
          //     print(citaSeleccionada.horario1);
          //     print(citaSeleccionada.horario2);
          //     print(citaSeleccionada.horario3);
          //   }, 
          //   nombre: 'Probar'
          // ),

          ButtonBlue(
            onPressed: () async {
              if (selectedCheckBox == -1) {
                NotificacionService.showSnackBar('Debe seleccionar un método de pago', Colors.red);
              } else {
                final newCita = Cita(
                  fecha   : citaSeleccionada!.fecha, 
                  paciente: citaSeleccionada.paciente,
                  horario1: citaSeleccionada.horario1,
                  horario2: citaSeleccionada.horario2,
                  horario3: citaSeleccionada.horario3,
                  diagnostico: '',
                  recomendaciones: '',
                );
                
                await Future.delayed(const Duration(seconds: 1));
                String? token = await citaService.crearCita(newCita);
                // citaForm.isLoading = false;

                if (token == null) {
                  NotificacionService.showSnackBar('Error al registrar', Colors.red);
                  // citaForm.isLoading = false;
                } else {
                  // ignore: use_build_context_synchronously
                  mostrarAlerta( context, 'Mensaje', '${citaSeleccionada.paciente}, tu reserva se realizó con éxito', 
                    [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, NotificacionScreenScreen.nombre);
                        },
                        elevation: 5,
                        textColor: Colors.blue,
                        child: const Text('Ok'),
                      ),
                    ]
                  );
                }
              }
            }, 
            nombre: 'Confirmar pago'
          ),

          const SizedBox(height: 10,),
          
          ButtonBlue(
            onPressed: () {
              Navigator.pop(context);
            }, 
            nombre: 'Regresar'
          ),


        ],
      ),
    );
  }
}

class _ImageTitlePago extends StatelessWidget {
  final String image;
  final String title;
  const _ImageTitlePago({
    super.key, 
    required this.image, 
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: LogoImage(
            image: image,
              height: 30
            ),
        ),

        Text(title),
      ],
    );
  }
}