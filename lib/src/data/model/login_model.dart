// To parse this JSON data, do
//
//     final responseBaseModel = responseBaseModelFromJson(jsonString);

import 'dart:convert';

LoginModel responseBaseModelFromJson(String str) => LoginModel.fromJson(json.decode(str));



class LoginModel {
    String? token;
    Usuario? usuario;

    LoginModel({
        this.token,
        this.usuario,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"] ??"",
        usuario: json["usuario"] == null ?  Usuario.fromJson({}) : Usuario.fromJson(json["usuario"]),
    );

   
}

class Usuario {
    int? idUsuario;
    String? nombres;
    String? apellidos;
    String? estado;
    String? correo;
    String? contrasenia;
    String? rol;
    DateTime? fechaCreacion;
    DateTime? fechaActualizacion;

    Usuario({
        this.idUsuario,
        this.nombres,
        this.apellidos,
        this.estado,
        this.correo,
        this.contrasenia,
        this.rol,
        this.fechaCreacion,
        this.fechaActualizacion,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["idUsuario"]??'',
        nombres: json["nombres"]??"",
        apellidos: json["apellidos"]??"",
        estado: json["estado"]??"",
        correo: json["correo"]??"",
        contrasenia: json["contrasenia"]??"",
        rol: json["rol"]??"",
        fechaCreacion: json["fechaCreacion"],
        fechaActualizacion: json["fechaActualizacion"],
    );

 
}
