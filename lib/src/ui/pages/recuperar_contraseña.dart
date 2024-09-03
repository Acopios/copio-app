// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/ui/blocs/login/login_cubit.dart';
import 'package:acopios/src/ui/helpers/alert_dialog_helper.dart';
import 'package:acopios/src/ui/pages/login_page.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class RecuperarContrasenia extends StatefulWidget {
  final bool isVerification;
  const RecuperarContrasenia({super.key, this.isVerification = false});

  @override
  State<RecuperarContrasenia> createState() => _RecuperarContraseniaState();
}

class _RecuperarContraseniaState extends State<RecuperarContrasenia> {
  bool loading = false;
  bool e1 = true;
  bool e2 = true;

  final txt1 = TextEditingController();

  final txt2 = TextEditingController();

  final txt3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 8,
        title:  Text(widget.isVerification?"Activar usuario": "Recuperar contraseña"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Visibility(
                    visible: widget.isVerification,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("Ingresa tu usuario asignado"))),
                  InputWidget(
                      controller: txt1,
                      hintText: "Usuario",
                      icon: Icons.person_2_outlined,
                      onChanged: (e) {
                        setState(() {});
                      }),
                  SizedBox(height: 20),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("Define tu nueva contraseña")),
                  InputWidget(
                      controller: txt2,
                      hintText: "Contraseña",
                      obscureText: e1,
                      suffixIcon: IconButton(
                          onPressed: () {
                            e1 = !e1;
                            setState(() {});
                          },
                          icon: e1
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      icon: Icons.lock_person_outlined,
                      onChanged: (e) {
                        setState(() {});
                      }),
                  SizedBox(height: 20),
                  InputWidget(
                      controller: txt3,
                      obscureText: e2,
                      hintText: "Confirmar Contraseña",
                      icon: Icons.lock_person_outlined,
                      suffixIcon: IconButton(
                          onPressed: () {
                            e2 = !e2;
                            setState(() {});
                          },
                          icon: e2
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      onChanged: (e) {
                        setState(() {});
                      }),
                  const SizedBox(height: 40),
                  BtnWidget(
                      action: () async {
                        final l = LoginCubit();
                        loading = true;
                        setState(() {});

                        if (widget.isVerification) {
                          final r = await l.activar(txt1.text, txt2.text);
                          loading = false;
                          setState(() {});
                          if (r) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                                (route) => false);
                          } else {
                            info(context, messageError,
                                () => Navigator.pop(context));
                          }
                        } else {
                          final r = await l.recuperar(txt1.text, txt2.text);
                          loading = false;
                          setState(() {});
                          if (r) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                                (route) => false);
                          } else {
                            info(context, messageError,
                                () => Navigator.pop(context));
                          }
                        }
                      },
                      txt: "Cambiar",
                      enabled: txt1.text.isNotEmpty &&
                          txt2.text.isNotEmpty &&
                          txt3.text.isNotEmpty &&
                          (txt2.text == txt3.text))
                ],
              ),
            ),
          ),
          Visibility(visible: loading, child: const LoadingWidget())
        ],
      ),
    ));
  }
}
