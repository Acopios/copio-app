class RegistroDto {
  final String nombres;
  final String apellidos;
  final String estado;
  final String correo;
  final String direccion;
  final String responsable;
  final String contrasenia;
  final String rol;
  final String fechaCreacion;
  final String fechaActualizacion;

  RegistroDto({
    required this.nombres,
    required this.apellidos,
    required this.estado,
    required this.correo,
    required this.contrasenia,
    required this.rol,
    required this.direccion,
    required this.responsable,
    required this.fechaCreacion,
    required this.fechaActualizacion,
  });

  Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion":direccion,
        "responsable":responsable,
        "estado": estado,
        "correo": correo,
        "contrasenia": contrasenia,
        "rol": rol,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion,
      };
}
