class MayoristaModel {
  final int? idMayorista;
  final String? nombre;
  final String? direccion;
  final String? nit;
  final String? representante;
  final DateTime? fechaCreacion;
  final DateTime? fechaActualizacion;

  MayoristaModel(
      {this.idMayorista,
      this.nombre,
      this.representante,
      this.nit,
      this.fechaCreacion,
      this.direccion,
      this.fechaActualizacion});

  factory MayoristaModel.fromJson(Map<String, dynamic> json) => MayoristaModel(
        idMayorista: json["idMayorista"] ?? 0,
        nombre: json["nombre"] ?? "",
        representante: json["representante"] ?? "",
        nit: json["nit"] ?? "",
        direccion: json["direccion"] ?? "",
        fechaCreacion: json["fechaCreacion"]==null?DateTime.now(): DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion:json["fechaActualizacion"]==null?DateTime.now(): DateTime.parse(json["fechaActualizacion"]),
      );
}
