import 'dart:convert';

class Cita {
    String? diagnostico;
    String? fecha;
    bool? horario1;
    bool? horario2;
    bool? horario3;
    final String paciente;
    String? recomendaciones;
    String? id;

    Cita({
        this.diagnostico,
        required this.fecha,
        this.horario1 = true,
        this.horario2 = true,
        this.horario3 = true,
        required this.paciente,
        this.recomendaciones,
        this.id,
    });

    factory Cita.fromRawJson(String str) => Cita.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Cita.fromJson(Map<String, dynamic> json) => Cita(
        diagnostico: json["diagnostico"],
        fecha: json["fecha"],
        horario1: json["horario1"],
        horario2: json["horario2"],
        horario3: json["horario3"],
        paciente: json["paciente"],
        recomendaciones: json["recomendaciones"],
    );

    Map<String, dynamic> toJson() => {
        "diagnostico": diagnostico,
        "fecha": fecha,
        "horario1": horario1,
        "horario2": horario2,
        "horario3": horario3,
        "paciente": paciente,
        "recomendaciones": recomendaciones,
    };
}
