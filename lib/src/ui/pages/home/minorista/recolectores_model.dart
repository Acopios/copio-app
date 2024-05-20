// To parse this JSON data, do
//
//     final recolectoresModel = recolectoresModelFromJson(jsonString);

import 'dart:convert';

RecolectoresModel recolectoresModelFromJson(String str) => RecolectoresModel.fromJson(json.decode(str));

String recolectoresModelToJson(RecolectoresModel data) => json.encode(data.toJson());

class RecolectoresModel {
    bool? success;
    String? message;
    List<BodyReco>? body;

    RecolectoresModel({
        this.success,
        this.message,
        this.body,
    });

    factory RecolectoresModel.fromJson(Map<String, dynamic> json) => RecolectoresModel(
        success: json["success"],
        message: json["message"],
        body: json["body"] == null ? [] : List<BodyReco>.from(json["body"]!.map((x) => BodyReco.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "body": body == null ? [] : List<dynamic>.from(body!.map((x) => x.toJson())),
    };
}

class BodyReco {
    int? idRecolector;
    String? nombres;
    String? apellidos;
    String? identificacion;
    dynamic fechaMacimiento;
    String? estado;
    DateTime? fechaCreacion;
    DateTime? fechaActualizacion;

    BodyReco({
        this.idRecolector,
        this.nombres,
        this.apellidos,
        this.identificacion,
        this.fechaMacimiento,
        this.estado,
        this.fechaCreacion,
        this.fechaActualizacion,
    });

    factory BodyReco.fromJson(Map<String, dynamic> json) => BodyReco(
        idRecolector: json["idRecolector"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        identificacion: json["identificacion"],
        fechaMacimiento: json["fechaMacimiento"],
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"] == null ? null : DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: json["fechaActualizacion"] == null ? null : DateTime.parse(json["fechaActualizacion"]),
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
    };
}
