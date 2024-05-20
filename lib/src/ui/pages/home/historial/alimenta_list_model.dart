// To parse this JSON data, do
//
//     final alimentaListadoResponseMondel = alimentaListadoResponseMondelFromJson(jsonString);

import 'dart:convert';

AlimentaListadoResponseMondel alimentaListadoResponseMondelFromJson(String str) => AlimentaListadoResponseMondel.fromJson(json.decode(str));

String alimentaListadoResponseMondelToJson(AlimentaListadoResponseMondel data) => json.encode(data.toJson());

class AlimentaListadoResponseMondel {
    bool? success;
    String? message;
    List<BodyAlimentaList>? body;

    AlimentaListadoResponseMondel({
        this.success,
        this.message,
        this.body,
    });

    factory AlimentaListadoResponseMondel.fromJson(Map<String, dynamic> json) => AlimentaListadoResponseMondel(
        success: json["success"],
        message: json["message"],
        body: json["body"] == null ? [] : List<BodyAlimentaList>.from(json["body"]!.map((x) => BodyAlimentaList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "body": body == null ? [] : List<dynamic>.from(body!.map((x) => x.toJson())),
    };
}

class BodyAlimentaList {
    DateTime? fecha;
    List<Alimento>? alimentos;

    BodyAlimentaList({
        this.fecha,
        this.alimentos,
    });

    factory BodyAlimentaList.fromJson(Map<String, dynamic> json) => BodyAlimentaList(
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        alimentos: json["alimentos"] == null ? [] : List<Alimento>.from(json["alimentos"]!.map((x) => Alimento.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "fecha": "${fecha!.year.toString().padLeft(4, '0')}-${fecha!.month.toString().padLeft(2, '0')}-${fecha!.day.toString().padLeft(2, '0')}",
        "alimentos": alimentos == null ? [] : List<dynamic>.from(alimentos!.map((x) => x.toJson())),
    };
}

class Alimento {
    int? id;
    IdMaterial? idMaterial;
    DateTime? fechaAlimenta;
    double? valor;

    Alimento({
        this.id,
        this.idMaterial,
        this.fechaAlimenta,
        this.valor,
    });

    factory Alimento.fromJson(Map<String, dynamic> json) => Alimento(
        id: json["id"],
        idMaterial: json["idMaterial"] == null ? null : IdMaterial.fromJson(json["idMaterial"]),
        fechaAlimenta: json["fechaAlimenta"] == null ? null : DateTime.parse(json["fechaAlimenta"]),
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idMaterial": idMaterial?.toJson(),
        "fechaAlimenta": fechaAlimenta?.toIso8601String(),
        "valor": valor,
    };
}

class IdMaterial {
    int? idMaterial;
    String? nombre;
    String? codigo;
    String? unidadMedida;
    DateTime? fechaCreacion;
    DateTime? fechaActualizacion;

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
        fechaCreacion: json["fechaCreacion"] == null ? null : DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: json["fechaActualizacion"] == null ? null : DateTime.parse(json["fechaActualizacion"]),
    );

    Map<String, dynamic> toJson() => {
        "idMaterial": idMaterial,
        "nombre": nombre,
        "codigo": codigo,
        "unidadMedida": unidadMedida,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaActualizacion": fechaActualizacion?.toIso8601String(),
    };
}
