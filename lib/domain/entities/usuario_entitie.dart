import 'dart:convert';

class Usuario {
    Usuario({
        required this.apellidos,
        required this.celular,
        required this.email,
        required this.nacimiento,
        required this.nombre,
        required this.password,
        this.id,
    });

    String apellidos;
    String celular;
    String email;
    String nacimiento;
    String nombre;
    String password;
    String? id;

    factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        apellidos: json["apellidos"],
        celular: json["celular"],
        email: json["email"],
        nacimiento: json["nacimiento"],
        nombre: json["nombre"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "apellidos": apellidos,
        "celular": celular,
        "email": email,
        "nacimiento": nacimiento,
        "nombre": nombre,
        "password": password,
    };

}
