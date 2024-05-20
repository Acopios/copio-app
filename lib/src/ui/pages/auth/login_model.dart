// To parse this JSON data, do
//
//     final precioMaterialMinoristaInterface = precioMaterialMinoristaInterfaceFromJson(jsonString);

import 'dart:convert';

Loginmodel precioMaterialMinoristaInterfaceFromJson(String str) => Loginmodel.fromJson(json.decode(str));


class Loginmodel {
    bool success;
    String message;
    Body body;

    Loginmodel({
        required this.success,
        required this.message,
        required this.body,
    });

    factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
        success: json["success"],
        message: json["message"],
        body: Body.fromJson(json["body"]),
    );

   
}

class Body {
    String token;
    Usuario? usuario;

    Body({
        required this.token,
         this.usuario,
    });

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        token: json["token"],
        usuario: Usuario.fromJson(json["usuario"]),
    );

   
}

class Usuario {
    int idUsuario;
    String nombre;
    String estado;
    String rol;

    Usuario({
        required this.idUsuario,
        required this.nombre,
        required this.estado,
        required this.rol,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        estado: json["estado"],
        rol: json["rol"],
    );

    Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "nombre": nombre,
        "estado": estado,
        "rol": rol,
    };
}
