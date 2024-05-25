class LoginDto{
  final String usuario;
  final String contrasenia;

  LoginDto({required this.usuario, required this.contrasenia});

  Map<String, dynamic> toJson()=>{
    "usuario":usuario,
    "contrasenia":contrasenia
  };
}