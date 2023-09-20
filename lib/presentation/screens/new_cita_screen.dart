import 'package:flutter/material.dart';

import 'package:dental_care_app/presentation/screens/metodo_pago_screen.dart';
import 'package:dental_care_app/presentation/widgets/button_blue.dart';
import 'package:dental_care_app/presentation/widgets/logo_image.dart';
import 'package:dental_care_app/presentation/widgets/title_subtitle.dart';
 
class NewCitaScreen extends StatelessWidget {
  static const nombre = 'newCitaScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [

              LogoImage(
                height: 130
              ),

              PacienteDoctor(),

              CalendarHorario(),

            ],
          ),
        )
      )
    );
  }
}

class CalendarHorario extends StatefulWidget {
  const CalendarHorario({super.key});

  @override
  State<CalendarHorario> createState() => _CalendarHorarioState();
}

class _CalendarHorarioState extends State<CalendarHorario> {

  DateTime? selectedDate;
  // bool firstActive = false;
  // bool secondActive = false;
  // bool thirdActive = false;
  int selectedCheckBox = -1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );

    return Container(
      width: double.infinity,
      // color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          TitleSubTitle(title: 'Fecha', horizontal: 0, vertical: 10),
          
          ButtonBlue(
            onPressed: () async {
              DateTime? date = await pickDate();
              if (date == null) return;
              selectedDate = date;
              setState(() {});
            }, 
            nombre: selectedDate != null ? selectedDate.toString().split(' ')[0] : 'Seleccionar fecha'
          ),

          TitleSubTitle(title: 'Horario', horizontal: 0, vertical: 10),

          CheckboxListTile(
            title: const Text('3 pm a 4 pm'),
            value: selectedCheckBox == 0,
            onChanged: (value) {
              // firstActive = value!;
              selectedCheckBox = 0;
              setState(() {});
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          
          CheckboxListTile(
            title: const Text('5 pm a 6 pm'),
            value: selectedCheckBox == 1,
            onChanged: (value) {
              // secondActive = value!;
              selectedCheckBox = 1;
              setState(() {});
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          
          CheckboxListTile(
            title: const Text('7 pm a 8 pm'),
            value: selectedCheckBox == 2,
            onChanged: (value) {
              // thirdActive = value!;
              selectedCheckBox = 2;
              setState(() {});
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),


          Container(
            padding: const EdgeInsets.symmetric( vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
          
                SizedBox(
                  width: size.width *0.4,
                  child: ButtonBlue(
                    onPressed: () {
                      // print(selectedCheckBox);
                      Navigator.pushNamed(context, MetodoPagoScreen.nombre);
                    }, 
                    nombre: 'Aceptar'
                  ),
                ),
                SizedBox(
                  width: size.width *0.4,
                  child: ButtonBlue(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    nombre: 'Regresar'
                  ),
                ),
                
          
              ],
            ),
          )

        ],
      ),
    );
  }
}

class PacienteDoctor extends StatelessWidget {
  const PacienteDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          UserPersonal(
            icon: Icons.person_outline,
            image: 'assets/images/patient-icon.jpg',
            title: 'Ruth R',
          ),
          
          UserPersonal(
            icon: Icons.troubleshoot_sharp,
            image: 'assets/images/doctor-icon.jpg',
            title: 'Marcelo P',
          ),

        ],
      ),
    );
  }
}

class UserPersonal extends StatelessWidget {
  final String image;
  final String title;
  final IconData icon;

  const UserPersonal({
    super.key, 
    required this.image, 
    required this.title, 
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              // color: Colors.red,
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
          ),
    
          Container(
            // color: Colors.red,
            width: size.width * 0.4,
            height: 60,
            child: ListTile(
              title: Text(title),
              leading: Icon(icon, color: Colors.blue,),
            ),
          ),
    
        ],
      ),
    );
  }
}