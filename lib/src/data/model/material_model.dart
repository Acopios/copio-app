// To parse this JSON data, do
//
//     final responseBaseModel = responseBaseModelFromJson(jsonString);

import 'dart:convert';

MaterialModel responseBaseModelFromJson(String str) => MaterialModel.fromJson(json.decode(str));



class MaterialModel {
    int? idMaterial;
    String? nombre;
    String? codigo;
    DateTime? fechaCreacion;
    DateTime? fechaActualizacion;

    MaterialModel({
        this.idMaterial,
        this.nombre,
        this.codigo,
        this.fechaCreacion,
        this.fechaActualizacion,
    });

    factory MaterialModel.fromJson(Map<String, dynamic> json) => MaterialModel(
        idMaterial: json["idMaterial"],
        nombre: json["nombre"],
        codigo: json["codigo"],
        fechaCreacion: json["fechaCreacion"] == null ? null : DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: json["fechaActualizacion"] == null ? null : DateTime.parse(json["fechaActualizacion"]),
    );

    Map<String, dynamic> toJson() => {
        "idMaterial": idMaterial,
        "nombre": nombre,
        "codigo": codigo,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaActualizacion": fechaActualizacion?.toIso8601String(),
    };
}
