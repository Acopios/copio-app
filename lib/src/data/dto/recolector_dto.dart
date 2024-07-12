class RecolectorDto {
  final String nombres;
  final String apellidos;
  final String direccion;
  final String telefono;
  final String identificacion;
  final int idMinorista;
  final int idListaPrecios;
  final int?idRecolector;

  RecolectorDto(
      {required this.nombres,
      required this.apellidos,
      required this.direccion,
      required this.idListaPrecios,
      this.idRecolector,
      required this.telefono,
      required this.identificacion,
      required this.idMinorista});

  Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion": direccion,
        "idListaPrecios":idListaPrecios,
        "telefono": telefono,
        "identificacion": identificacion,
        "idMinorista": idMinorista,
        "idRecolector":idRecolector
      };
}
