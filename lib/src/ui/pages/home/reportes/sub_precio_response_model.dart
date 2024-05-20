// To parse this JSON data, do
//
//     final subPrecioResponseModel = subPrecioResponseModelFromJson(jsonString);

import 'dart:convert';

SubPrecioResponseModel subPrecioResponseModelFromJson(String str) => SubPrecioResponseModel.fromJson(json.decode(str));

String subPrecioResponseModelToJson(SubPrecioResponseModel data) => json.encode(data.toJson());

class SubPrecioResponseModel {
    bool? success;
    String? message;
    BodySubPrecio? body;

    SubPrecioResponseModel({
        this.success,
        this.message,
        this.body,
    });

    factory SubPrecioResponseModel.fromJson(Map<String, dynamic> json) => SubPrecioResponseModel(
        success: json["success"],
        message: json["message"],
        body: json["body"] == null ? null : BodySubPrecio.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "body": body?.toJson(),
    };
}

class BodySubPrecio {
    int? idSubprecio;
    double? valor;
    DateTime? fechaCreacion;
    DateTime? fechaActualizacion;
    IdMaterial? idMaterial;
    IdPrecio? idPrecio;

    BodySubPrecio({
        this.idSubprecio,
        this.valor,
        this.fechaCreacion,
        this.fechaActualizacion,
        this.idMaterial,
        this.idPrecio,
    });

    factory BodySubPrecio.fromJson(Map<String, dynamic> json) => BodySubPrecio(
        idSubprecio: json["idSubprecio"],
        valor: json["valor"],
        fechaCreacion: json["fechaCreacion"] == null ? null : DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: json["fechaActualizacion"] == null ? null : DateTime.parse(json["fechaActualizacion"]),
        idMaterial: json["idMaterial"] == null ? null : IdMaterial.fromJson(json["idMaterial"]),
        idPrecio: json["idPrecio"] == null ? null : IdPrecio.fromJson(json["idPrecio"]),
    );

    Map<String, dynamic> toJson() => {
        "idSubprecio": idSubprecio,
        "valor": valor,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaActualizacion": fechaActualizacion?.toIso8601String(),
        "idMaterial": idMaterial?.toJson(),
        "idPrecio": idPrecio?.toJson(),
    };
}

class IdMaterial {
    int? idMaterial;
    dynamic nombre;
    dynamic codigo;
    dynamic unidadMedida;
    dynamic fechaCreacion;
    dynamic fechaActualizacion;

    IdMaterial({
        this.idMaterial,
        this.nombre,
        this.codigo,
        this.unidadMedida,
        this.fechaCreacion,
        this.fechaActualizacion,
    });

    factory IdMaterial.fromJson(Map<String, dynamic> json) => IdMaterial(
        idMaterial: json["idMaterial"],
        nombre: json["nombre"],
        codigo: json["codigo"],
        unidadMedida: json["unidadMedida"],
        fechaCreacion: json["fechaCreacion"],
        fechaActualizacion: json["fechaActualizacion"],
    );

    Map<String, dynamic> toJson() => {
        "idMaterial": idMaterial,
        "nombre": nombre,
        "codigo": codigo,
        "unidadMedida": unidadMedida,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion,
    };
}

class IdPrecio {
    int? idPrecio;
    dynamic valor;
    dynamic fechaCreacion;
    dynamic fechaActualizacion;
    dynamic idMaterial;

    IdPrecio({
        this.idPrecio,
        this.valor,
        this.fechaCreacion,
        this.fechaActualizacion,
        this.idMaterial,
    });

    factory IdPrecio.fromJson(Map<String, dynamic> json) => IdPrecio(
        idPrecio: json["idPrecio"],
        valor: json["valor"],
        fechaCreacion: json["fechaCreacion"],
        fechaActualizacion: json["fechaActualizacion"],
        idMaterial: json["idMaterial"],
    );

    Map<String, dynamic> toJson() => {
        "idPrecio": idPrecio,
        "valor": valor,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion,
        "idMaterial": idMaterial,
    };
}
