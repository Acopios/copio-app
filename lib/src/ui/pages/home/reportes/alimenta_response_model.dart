// To parse this JSON data, do
//
//     final alimentaResponseMondel = alimentaResponseMondelFromJson(jsonString);

import 'dart:convert';

AlimentaResponseMondel alimentaResponseMondelFromJson(String str) => AlimentaResponseMondel.fromJson(json.decode(str));

String alimentaResponseMondelToJson(AlimentaResponseMondel data) => json.encode(data.toJson());

class AlimentaResponseMondel {
    bool? success;
    String? message;
    Body? body;

    AlimentaResponseMondel({
        this.success,
        this.message,
        this.body,
    });

    factory AlimentaResponseMondel.fromJson(Map<String, dynamic> json) => AlimentaResponseMondel(
        success: json["success"],
        message: json["message"],
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "body": body?.toJson(),
    };
}

class Body {
    int? id;
    IdRecolector? idRecolector;
    IdMinorista? idMinorista;
    IdMaterial? idMaterial;
    dynamic fechaAlimenta;
    double? valor;

    Body({
        this.id,
        this.idRecolector,
        this.idMinorista,
        this.idMaterial,
        this.fechaAlimenta,
        this.valor,
    });

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        id: json["id"],
        idRecolector: json["idRecolector"] == null ? null : IdRecolector.fromJson(json["idRecolector"]),
        idMinorista: json["idMinorista"] == null ? null : IdMinorista.fromJson(json["idMinorista"]),
        idMaterial: json["idMaterial"] == null ? null : IdMaterial.fromJson(json["idMaterial"]),
        fechaAlimenta: json["fechaAlimenta"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idRecolector": idRecolector?.toJson(),
        "idMinorista": idMinorista?.toJson(),
        "idMaterial": idMaterial?.toJson(),
        "fechaAlimenta": fechaAlimenta,
        "valor": valor,
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

class IdMinorista {
    int? idUsuario;
    dynamic nombre;
    dynamic usuario;
    dynamic estado;
    dynamic fechaCreacion;
    dynamic fechaActualizacion;
    dynamic direccion;
    dynamic responsable;

    IdMinorista({
        this.idUsuario,
        this.nombre,
        this.usuario,
        this.estado,
        this.fechaCreacion,
        this.fechaActualizacion,
        this.direccion,
        this.responsable,
    });

    factory IdMinorista.fromJson(Map<String, dynamic> json) => IdMinorista(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        usuario: json["usuario"],
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"],
        fechaActualizacion: json["fechaActualizacion"],
        direccion: json["direccion"],
        responsable: json["responsable"],
    );

    Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "nombre": nombre,
        "usuario": usuario,
        "estado": estado,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion,
        "direccion": direccion,
        "responsable": responsable,
    };
}

class IdRecolector {
    int? idRecolector;
    dynamic nombres;
    dynamic apellidos;
    dynamic identificacion;
    dynamic fechaMacimiento;
    dynamic estado;
    dynamic fechaCreacion;
    dynamic fechaActualizacion;

    IdRecolector({
        this.idRecolector,
        this.nombres,
        this.apellidos,
        this.identificacion,
        this.fechaMacimiento,
        this.estado,
        this.fechaCreacion,
        this.fechaActualizacion,
    });

    factory IdRecolector.fromJson(Map<String, dynamic> json) => IdRecolector(
        idRecolector: json["idRecolector"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        identificacion: json["identificacion"],
        fechaMacimiento: json["fechaMacimiento"],
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"],
        fechaActualizacion: json["fechaActualizacion"],
    );

    Map<String, dynamic> toJson() => {
        "idRecolector": idRecolector,
        "nombres": nombres,
        "apellidos": apellidos,
        "identificacion": identificacion,
        "fechaMacimiento": fechaMacimiento,
        "estado": estado,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion,
    };
}
