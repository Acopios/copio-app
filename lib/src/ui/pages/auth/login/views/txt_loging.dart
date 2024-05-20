import 'package:flutter/material.dart';

class TextLogin extends StatelessWidget {
  TextLogin({super.key});
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Text(
      "Inicio de sesión",
      style:
          TextStyle(fontSize: _size.height * .024, fontWeight: FontWeight.bold),
    );
  }
}
