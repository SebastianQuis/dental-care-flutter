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


List<Cita> convertirMapaACitas(Map<String, dynamic> mapa) {
  List<Cita> citas = [];

  mapa.forEach((key, value) {
    Cita cita = Cita.fromJson(value);
    cita.id = key;
    citas.add(cita);
  });

  return citas;
}
