// To parse this JSON data, do
//
//     final movimientosModel = movimientosModelFromJson(jsonString);

import 'dart:convert';

import 'package:acopios/src/data/model/material_model.dart';
import 'package:acopios/src/data/model/recolector_model.dart';

MovimientosModel movimientosModelFromJson(String str) =>
    MovimientosModel.fromJson(json.decode(str));

class MovimientosModel {
  DateTime? fecha;
  RecolectorModel? recolector;
  ComprasPorRecolector? comprasPorRecolector;

  MovimientosModel({
    this.fecha,
    this.recolector,
    this.comprasPorRecolector,
  });

  factory MovimientosModel.fromJson(Map<String, dynamic> json) =>
      MovimientosModel(
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        recolector: json["recolector"] == null ? null : RecolectorModel.fromJson(json["recolector"]),
        comprasPorRecolector: json["comprasPorRecolector"] == null
            ? null
            : ComprasPorRecolector.fromJson(json["comprasPorRecolector"]),
      );

  Map<String, dynamic> toJson() => {
        "fecha":
            "${fecha!.year.toString().padLeft(4, '0')}-${fecha!.month.toString().padLeft(2, '0')}-${fecha!.day.toString().padLeft(2, '0')}",
        "comprasPorRecolector": comprasPorRecolector?.toJson(),
      };
}

class ComprasPorRecolector {
  List<Compra>? compras;

  ComprasPorRecolector({
    this.compras,
  });

  factory ComprasPorRecolector.fromJson(Map<String, dynamic> json) =>
      ComprasPorRecolector(
        compras: json["Compras"] == null
            ? []
            : List<Compra>.from(
                json["Compras"]!.map((x) => Compra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Compras": compras == null
            ? []
            : List<dynamic>.from(compras!.map((x) => x.toJson())),
      };
}

class Compra {
  int? id;
  MaterialModel? idMaterial;
  DateTime? fechaAlimenta;
  double? cantidad;
  double? precioUnidad;
  double? total;

  Compra({
    this.id,
    this.idMaterial,
    this.fechaAlimenta,
    this.cantidad,
    this.precioUnidad,
    this.total,
  });

  factory Compra.fromJson(Map<String, dynamic> json) => Compra(
        id: json["id"],
        idMaterial: json["material"] == null
            ? null
            : MaterialModel.fromJson(json["material"]),
        fechaAlimenta: json["fechaAlimenta"] == null
            ? null
            : DateTime.parse(json["fechaAlimenta"]),
        cantidad: json["cantidad"],
        precioUnidad: json["precioUnidad"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idMaterial": idMaterial?.toJson(),
        "fechaAlimenta": fechaAlimenta?.toIso8601String(),
        "cantidad": cantidad,
        "precioUnidad": precioUnidad,
        "total": total,
      };
}

class IdRecolector {
  int? idRecolector;
  String? nombres;
  String? apellidos;
  String? direccion;
  String? identificacion;
  String? telefono;

  IdRecolector({
    this.idRecolector,
    this.nombres,
    this.apellidos,
    this.direccion,
    this.identificacion,
    this.telefono,
  });

  factory IdRecolector.fromJson(Map<String, dynamic> json) => IdRecolector(
        idRecolector: json["idRecolector"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        direccion: json["direccion"],
        identificacion: json["identificacion"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toJson() => {
        "idRecolector": idRecolector,
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion": direccion,
        "identificacion": identificacion,
        "telefono": telefono,
      };
}
