class MayoristaModel {
  final int? idMayorista;
  final String? nombre;
  final DateTime? fechaCreacion;
  final DateTime? fechaActualizacion;

  MayoristaModel(
      {this.idMayorista,
      this.nombre,
      this.fechaCreacion,
      this.fechaActualizacion});

  factory MayoristaModel.fromJson(Map<String, dynamic> json) => MayoristaModel(
        idMayorista: json["idMayorista"] ?? 0,
        nombre: json["nombre"] ?? "",
        fechaCreacion: json["fechaCreacion"]==null?DateTime.now(): DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion:json["fechaActualizacion"]==null?DateTime.now(): DateTime.parse(json[""]),
      );
}
