// To parse this JSON data, do
//
//     final precioMaterial = precioMaterialFromJson(jsonString);

import 'dart:convert';

PrecioMaterial precioMaterialFromJson(String str) => PrecioMaterial.fromJson(json.decode(str));

String precioMaterialToJson(PrecioMaterial data) => json.encode(data.toJson());


class PrecioMaterial {
    int idAsignacion;
    List<Precio> precios;

    PrecioMaterial({
        required this.idAsignacion,
        required this.precios,
    });

    factory PrecioMaterial.fromJson(Map<String, dynamic> json) => PrecioMaterial(
        idAsignacion: json["idAsignacion"],
        precios: List<Precio>.from(json["precios"].map((x) => Precio.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idAsignacion": idAsignacion,
        "precios": List<dynamic>.from(precios.map((x) => x.toJson())),
    };
}

class Precio {
    int id;
    IdMaterial idMaterial;
    DateTime fechaAsigna;
    double valor;
    int idAsignacion;

    Precio({
        required this.id,
        required this.idMaterial,
        required this.fechaAsigna,
        required this.valor,
        required this.idAsignacion,
    });

    factory Precio.fromJson(Map<String, dynamic> json) => Precio(
        id: json["id"],
        idMaterial: IdMaterial.fromJson(json["idMaterial"]),
        fechaAsigna: DateTime.parse(json["fechaAsigna"]),
        valor: json["valor"],
        idAsignacion: json["idAsignacion"],
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
