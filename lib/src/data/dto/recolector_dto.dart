class RecolectorDto {
  final String nombres;
  final String apellidos;
  final String direccion;
  final String telefono;
  final String identificacion;
  final int idMinorista;

  RecolectorDto(
      {required this.nombres,
      required this.apellidos,
      required this.direccion,
      required this.telefono,
      required this.identificacion,
      required this.idMinorista});

  Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion": direccion,
        "telefono": telefono,
        "identificacion": identificacion,
        "idMinorista": idMinorista,
      };
}
