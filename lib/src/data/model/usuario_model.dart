class UsuarioModel {
  final int? idUsuario;
  final String? nombre;
  final String? apellidos;
  final String? correo;
  final String? estado;
  final String? direccion;
  final String? responsable;

  UsuarioModel(
      {this.idUsuario,
      this.nombre,
      this.apellidos,
      this.correo,
      this.estado,
      this.direccion,
      this.responsable});
  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      apellidos: json["apellidos"] ?? "",
      correo: json["correo"] ?? "",
      direccion: json["direccion"] ?? "",
      estado: json["estado"] ?? "",
      idUsuario: json["idUsuario"] ?? 0,
      nombre: json["nombre"] ?? "",
      responsable: json["responsable"] ?? "",
    );
  }
}
