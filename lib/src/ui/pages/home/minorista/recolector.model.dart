// To parse this JSON data, do
//
//     final recolectorModel = recolectorModelFromJson(jsonString);

import 'dart:convert';

RecolectorModel recolectorModelFromJson(String str) => RecolectorModel.fromJson(json.decode(str));

String recolectorModelToJson(RecolectorModel data) => json.encode(data.toJson());

class RecolectorModel {
    bool? success;
    String? message;
    Body? body;

    RecolectorModel({
        this.success,
        this.message,
        this.body,
    });

    factory RecolectorModel.fromJson(Map<String, dynamic> json) => RecolectorModel(
        success: json["success"],
        message: json["message"],
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "body": body?.toJson(),
    };
}

class Body {
    int? idRecolector;
    String? nombres;
    String? apellidos;
    String? identificacion;
    dynamic fechaMacimiento;
    String? estado;
    DateTime? fechaCreacion;
    DateTime? fechaActualizacion;
    IdMinorista? idMinorista;

    Body({
        this.idRecolector,
        this.nombres,
        this.apellidos,
        this.identificacion,
        this.fechaMacimiento,
        this.estado,
        this.fechaCreacion,
        this.fechaActualizacion,
        this.idMinorista,
    });

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        idRecolector: json["idRecolector"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        identificacion: json["identificacion"],
        fechaMacimiento: json["fechaMacimiento"],
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"] == null ? null : DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: json["fechaActualizacion"] == null ? null : DateTime.parse(json["fechaActualizacion"]),
        idMinorista: json["idMinorista"] == null ? null : IdMinorista.fromJson(json["idMinorista"]),
    );

    Map<String, dynamic> toJson() => {
        "idRecolector": idRecolector,
        "nombres": nombres,
        "apellidos": apellidos,
        "identificacion": identificacion,
        "fechaMacimiento": fechaMacimiento,
        "estado": estado,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaActualizacion": fechaActualizacion?.toIso8601String(),
        "idMinorista": idMinorista?.toJson(),
    };
}

class IdMinorista {
    int? idUsuario;
    dynamic nombre;
    dynamic usuario;
    dynamic estado;
    dynamic fechaCreacion;
    dynamic fechaActualizacion;
    dynamic direccion;
    dynamic responsable;

    IdMinorista({
        this.idUsuario,
        this.nombre,
        this.usuario,
        this.estado,
        this.fechaCreacion,
        this.fechaActualizacion,
        this.direccion,
        this.responsable,
    });

    factory IdMinorista.fromJson(Map<String, dynamic> json) => IdMinorista(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        usuario: json["usuario"],
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"],
        fechaActualizacion: json["fechaActualizacion"],
        direccion: json["direccion"],
        responsable: json["responsable"],
    );

    Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "nombre": nombre,
        "usuario": usuario,
        "estado": estado,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion,
        "direccion": direccion,
        "responsable": responsable,
    };
}
