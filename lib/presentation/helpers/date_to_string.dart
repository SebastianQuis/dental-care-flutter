import 'package:dental_care_app/domain/entities/cita_entitie.dart';
import 'package:intl/intl.dart';

String parseDateTimeString(DateTime dateTime) {
  DateFormat format = DateFormat('dd/MM/yyyy');
  return format.format(dateTime);
}

DateTime? parseStringDateTime(String dateTime) {
  try {
    List<String> parts = dateTime.split('/');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  } catch (e) {
    return null;
  }
}

String formatDateCalendar(DateTime day) {
  final diaDeLaSemana = day.weekday;
  String nombreDelDia = '';
  
  switch (diaDeLaSemana) {
    case 1:
      nombreDelDia = 'Lunes';
      break;
    case 2:
      nombreDelDia = 'Martes';
      break;
    case 3:
      nombreDelDia = 'Miércoles';
      break;
    case 4:
      nombreDelDia = 'Jueves';
      break;
    case 5:
      nombreDelDia = 'Viernes';
      break;
    case 6:
      nombreDelDia = 'Sábado';
      break;
    case 7:
      nombreDelDia = 'Domingo';
      break;
  }

  return nombreDelDia;
}

String fomatMonthCalendar(String month) {
  String? nombreMes;
  switch (month) {
    case '1':
      nombreMes = 'enero';
      break;
    case '2':
      nombreMes = 'febrero';
      break;
    case '3':
      nombreMes = 'marzo';
      break;
    case '4':
      nombreMes = 'abril';
      break;
    case '5':
      nombreMes = 'mayo';
      break;
    case '6':
      nombreMes = 'junio';
      break;
    case '7':
      nombreMes = 'julio';
      break;
    case '8':
      nombreMes = 'agosto';
      break;
    case '9':
      nombreMes = 'septiembre';
      break;
    case '10':
      nombreMes = 'octubre';
      break;
    case '11':
      nombreMes = 'noviembre';
      break;
    case '12':
      nombreMes = 'diciembre';
      break;
  }

  return nombreMes!;
}

List<Cita> convertirMapaACitas(Map<String, dynamic> mapa) {
  List<Cita> citas = [];

  mapa.forEach((key, value) {
    Cita cita = Cita.fromJson(value);
    cita.id = key;
    citas.add(cita);
  });

  return citas;
}
