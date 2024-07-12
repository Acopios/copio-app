// To parse this JSON data, do
//
//     final precioMaterial = precioMaterialFromJson(jsonString);

import 'dart:convert';

import 'package:acopios/src/data/model/recolector_model.dart';

import 'mayorista_model.dart';

PrecioMaterial precioMaterialFromJson(String str) => PrecioMaterial.fromJson(json.decode(str));

String precioMaterialToJson(PrecioMaterial data) => json.encode(data.toJson());


class PrecioMaterial {
    int idAsignacion;
    List<PrecioModel> precios;

    PrecioMaterial({
        required this.idAsignacion,
        required this.precios,
    });

    factory PrecioMaterial.fromJson(Map<String, dynamic> json) => PrecioMaterial(
        idAsignacion: json["idAsignacion"],
        precios: List<PrecioModel>.from(json["precios"].map((x) => PrecioModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idAsignacion": idAsignacion,
        "precios": List<dynamic>.from(precios.map((x) => x.toJson())),
    };
}

class PrecioModel {
    int id;
    RecolectorModel? recolectorModel;
    MayoristaModel? mayorista;
    IdMaterial idMaterial;
    DateTime fechaAsigna;
    DateTime? fechaAlimenta;
    double valor;
    double? cantidad;
    double? precioUnidad;
    double? total;
    int idAsignacion;

    PrecioModel({
        required this.id,
        this.recolectorModel,
        required this.idMaterial,
        this.fechaAlimenta,
        this.cantidad,
        this.total,
        this.precioUnidad,
        this.mayorista,
        required this.fechaAsigna,
        required this.valor,
        required this.idAsignacion,
    });

    factory PrecioModel.fromJson(Map<String, dynamic> json) => PrecioModel(
        id: json["id"] ?? -1,
        idMaterial: IdMaterial.fromJson(json["material"]),
        recolectorModel:json["recolector"]==null?RecolectorModel.fromJson({}): RecolectorModel.fromJson(json["recolector"]) ,
        fechaAsigna: json["fechaAsigna"]==null?DateTime.now(): DateTime.parse(json["fechaAsigna"] ),
        fechaAlimenta: json["fechaAlimenta"]==null?DateTime.now(): DateTime.parse(json["fechaAlimenta"]),
        valor: json["valor"] ??0.0,
        cantidad: json["cantidad"] ??0.0,
        total: json["total"] ??0.0,
        mayorista: json["mayorista"]==null?MayoristaModel.fromJson({}): MayoristaModel.fromJson(json["mayorista"]),
        idAsignacion: json["idAsignacion"] ??0,
        precioUnidad: json["precioUnidad"] ??0.0,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idMaterial": idMaterial.toJson(),
        "fechaAsigna": fechaAsigna.toIso8601String(),
        "valor": valor,
        "idAsignacion": idAsignacion,
    };
}

class IdMaterial {
    int idMaterial;
    String nombre;
    String codigo;
    DateTime fechaCreacion;
    DateTime fechaActualizacion;

    IdMaterial({
        required this.idMaterial,
        required this.nombre,
        required this.codigo,
        required this.fechaCreacion,
        required this.fechaActualizacion,
    });

    factory IdMaterial.fromJson(Map<String, dynamic> json) => IdMaterial(
        idMaterial: json["idMaterial"],
        nombre: json["nombre"],
        codigo: json["codigo"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: DateTime.parse(json["fechaActualizacion"]),
    );

    Map<String, dynamic> toJson() => {
        "idMaterial": idMaterial,
        "nombre": nombre,
        "codigo": codigo,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaActualizacion": fechaActualizacion.toIso8601String(),
    };
}
