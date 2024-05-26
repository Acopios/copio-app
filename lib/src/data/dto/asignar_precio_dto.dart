class AsignarPrecioDto {
  final int idMaterial;
  final int idMinorista;
  final String fechaAsigna;
  final double valor;

  AsignarPrecioDto({
    required this.idMaterial,
    required this.idMinorista,
    required this.fechaAsigna,
    required this.valor,
  });

  Map<String, dynamic> toJson() => {
        "idMaterial": idMaterial,
        "idMinorista": idMinorista,
        "fechaAsigna": fechaAsigna,
        "valor": valor,
      };
}
