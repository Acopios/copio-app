// To parse this JSON data, do
//
//     final responseBaseModel = responseBaseModelFromJson(jsonString);

import 'dart:convert';

RecolectorModel responseBaseModelFromJson(String str) => RecolectorModel.fromJson(json.decode(str));

class RecolectorModel {
    int? idRecolector;
    String? nombres;
    String? apellidos;
    String? direccion;
    String? identificacion;
    String? telefono;
    int? idListaPrecios;

    RecolectorModel({
        this.idRecolector,
        this.nombres,
        this.apellidos,
        this.direccion,
        this.identificacion,
        this.telefono,
        this.idListaPrecios
    });

    factory RecolectorModel.fromJson(Map<String, dynamic> json) => RecolectorModel(
        idRecolector: json["idRecolector"],
        nombres: json["nombres"],
        idListaPrecios:json["idListaPrecios"],
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
