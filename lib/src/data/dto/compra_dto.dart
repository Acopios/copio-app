class CompraDto {
  final int idRecolector;

  final int idMinorista;

  final int idMaterial;

  final String fechaAlimenta;

  final double cantidad;

  final double precioUnidad;

  final double total;

  CompraDto(
      {required this.idRecolector,
      required this.idMinorista,
      required this.idMaterial,
      required this.fechaAlimenta,
      required this.cantidad,
      required this.precioUnidad,
      required this.total});

  Map<String, dynamic> toJson() => {
        "idRecolector": idRecolector,
        "idMinorista": idMinorista,
        "idMaterial": idMaterial,
        "fechaAlimenta": fechaAlimenta,
        "cantidad": cantidad,
        "precioUnidad": precioUnidad,
        "total": total,
      };
}
