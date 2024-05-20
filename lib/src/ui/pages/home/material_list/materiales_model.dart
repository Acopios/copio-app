// To parse this JSON data, do
//
//     final materialesModel = materialesModelFromJson(jsonString);

import 'dart:convert';

MaterialesModel materialesModelFromJson(String str) => MaterialesModel.fromJson(json.decode(str));

String materialesModelToJson(MaterialesModel data) => json.encode(data.toJson());

class MaterialesModel {
    bool? success;
    String? message;
    List<BodyMaterial>? body;

    MaterialesModel({
        this.success,
        this.message,
        this.body,
    });

    factory MaterialesModel.fromJson(Map<String, dynamic> json) => MaterialesModel(
        success: json["success"],
        message: json["message"],
        body: json["body"] == null ? [] : List<BodyMaterial>.from(json["body"]!.map((x) => BodyMaterial.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "body": body == null ? [] : List<dynamic>.from(body!.map((x) => x.toJson())),
    };
}

class BodyMaterial {
    double? valor;
    int? idMaterial;
    int? idPrecio;
    String? nombre;
    String? codigo;

    BodyMaterial({
        this.valor,
        this.nombre,
        this.codigo,
        this.idMaterial,
        this.idPrecio,
    });

    factory BodyMaterial.fromJson(Map<String, dynamic> json) => BodyMaterial(
        valor: json["valor"],
        idMaterial: json["idMaterial"],
        nombre: json["nombre"],
        codigo: json["codigo"],
        idPrecio: json["idPrecio"],
    );

    Map<String, dynamic> toJson() => {
        "valor": valor,
        "nombre": nombre,
        "codigo": codigo,
    };
}
