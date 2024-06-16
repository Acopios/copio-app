class CrearMayoristaDto {
  final String nombre;
  final int idMinorista;
  final String fechaCreacion;
  final String fechaActualizacion;

  CrearMayoristaDto( 
      {required this.nombre, required this.idMinorista,
     required this.fechaCreacion, required this.fechaActualizacion,
      });

  Map<String, dynamic> toData() => {
        "nombre": nombre,
        "idMinorista": idMinorista,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion,
      };
}
