// To parse this JSON data, do
//
//     final responseBaseModel = responseBaseModelFromJson(jsonString);

import 'dart:convert';

import 'material_model.dart';

PrecioMaterial responseBaseModelFromJson(String str) =>
    PrecioMaterial.fromJson(json.decode(str));

class PrecioMaterial {
  int? id;
  MaterialModel? idMaterial;
  DateTime? fechaAsigna;
  double? valor;

  PrecioMaterial({
    this.id,
    this.idMaterial,
    this.fechaAsigna,
    this.valor,
  });

  factory PrecioMaterial.fromJson(Map<String, dynamic> json) => PrecioMaterial(
        id: json["id"],
        idMaterial: json["idMaterial"] == null
            ? null
            : MaterialModel.fromJson(json["idMaterial"]),
        fechaAsigna: json["fechaAsigna"] == null
            ? null
            : DateTime.parse(json["fechaAsigna"]),
        valor: json["valor"] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idMaterial": idMaterial?.toJson(),
        "fechaAsigna": fechaAsigna?.toIso8601String(),
        "valor": valor,
      };
}
