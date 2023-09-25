import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/screens/screens.dart';
import 'package:dental_care_app/presentation/widgets/widgets.dart';
 
class MetodoPagoScreen extends StatelessWidget {
  static const nombre = 'metodoPagoScreen';

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
          
              const TipoPago(),
          
          
            ],
          ),
        )),
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
    // final size = MediaQuery.of(context).size;
    
    return Container(
      // color: Colors.green,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // width: size.width * 0.9,
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

          ButtonBlue(
            onPressed: () {
              mostrarAlerta(
                context, 
                'Mensaje', 
                'Ruth, tu reserva se realizó con éxito', 
                [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, NotificacionScreenScreen.nombre);
                    },
                    elevation: 5,
                    textColor: Colors.blue,
                    child: const Text('Ok'),
                  ),
                ]);
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