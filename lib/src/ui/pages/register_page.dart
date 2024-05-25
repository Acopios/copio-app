import 'package:acopios/src/ui/widgets/chech_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/btn_widget.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text("Crear cuenta"),
      ),
      body: _body(),
    ));
  }

  Widget _body() => Container(
        margin:
            EdgeInsets.symmetric(horizontal: _size.width * .1, vertical: 30),
        child: Column(
          children: [
            _space(30),
            InputWidget(
                controller: TextEditingController(),
                hintText: "Nombres",
                icon: Icons.person,
                onChanged: (e) {}),
            _space(10),
            InputWidget(
                controller: TextEditingController(),
                hintText: "Apelllidos",
                icon: Icons.person,
                onChanged: (e) {}),
            _space(10),
            InputWidget(
                controller: TextEditingController(),
                hintText: "Númer celular",
                icon: Icons.phone,
                onChanged: (e) {}),
            _space(10),
            InputWidget(
                controller: TextEditingController(),
                hintText: "Usuario",
                icon: Icons.person,
                onChanged: (e) {}),
            _space(10),
            InputWidget(
                controller: TextEditingController(),
                hintText: "Contraseña",
                icon: Icons.lock_rounded,
                onChanged: (e) {}),
            _space(10),
            CheckWidget(
              enabled: false,
              onChanged: (e) {},
              txt: "Aceptar términos y condiciones",
            ),
            CheckWidget(
              enabled: false,
              onChanged: (e) {},
              txt: "Aceptar tratamiento de datos y politica de uso",
            ),
            _space(20),
            BtnWidget(enabled: true, action: () {}, txt: "Registrar"),
          ],
        ),
      );

  Widget _space(double space) => SizedBox(height: space);
}
