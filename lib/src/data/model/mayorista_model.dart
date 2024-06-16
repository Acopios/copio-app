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
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: DateTime.parse(json["fechaActualizacion"]),
      );
}
