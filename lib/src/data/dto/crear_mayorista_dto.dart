class CrearMayoristaDto {
  final String nombre;
  final int idMinorista;
  final String fechaCreacion;
  final String fechaActualizacion;
  final String representante;
  final String nit;
  final String direccion;
  final String telefono;
  final String correo;
  final int? idMayorista;

  CrearMayoristaDto({
    required this.nombre,
    required this.idMinorista,
    required this.fechaCreacion,
    required this.fechaActualizacion,
    required this.representante,
    required this.nit,
    required this.correo,
    required this.telefono,
    this.idMayorista,
    required this.direccion,
  });

  Map<String, dynamic> toData() => {
        "nombre": nombre,
        "representante": representante,
        "nit": nit,
        "idMayorista":idMayorista,
        "direccion": direccion,
        "idMinorista": idMinorista,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion,
        "correo":correo,
        "telefono":telefono

      };
}
