class AsignarPrecioDto {
  final int idMaterial;
  final int idMinorista;
  final int idAsignacion;
  final String fechaAsigna;
  final double valor;

  AsignarPrecioDto({
    required this.idMaterial,
    required this.idMinorista,
    required this.fechaAsigna,
    required this.valor,
    required this.idAsignacion
  });

  Map<String, dynamic> toJson() => {
        "idMaterial": idMaterial,
        "idMinorista": idMinorista,
        "fechaAsigna": fechaAsigna,
        "valor": valor,
        "idAsignacion": idAsignacion,
      };
}
