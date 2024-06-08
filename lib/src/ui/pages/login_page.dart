// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/ui/blocs/login/login_cubit.dart';
import 'package:acopios/src/ui/helpers/alert_dialog_helper.dart';
import 'package:acopios/src/ui/pages/home_page.dart';
import 'package:acopios/src/ui/pages/register_page.dart';
import 'package:acopios/src/ui/views/logo_view.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size _size;

  late LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = LoginCubit();
    _init();
  }

  _init() async {
    if (await _cubit.isLoged()) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const HomePage()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);

    return BlocProvider(
      create: (context) => _cubit,
      child: SafeArea(
          child: Scaffold(
        body: _body(),
      )),
    );
  }

  Widget _body() => Column(
        children: [
          _space(_size.height * .1),
          Center(child: logoView(heigth: _size.height * .2)),
          _space(_size.height * .018),
          Text("Inciar Sesión",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: _size.height * .02)),
          _form(),
          _btn(),
          _space(30),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((_) => const Registerpage())));
            },
            child: const Text(
              "Crear cuenta",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ],
      );

  Widget _form() => Container(
        margin:
            EdgeInsets.symmetric(horizontal: _size.width * .1, vertical: 30),
        child: Column(
          children: [
            InputWidget(
                controller: _cubit.user,
                hintText: "Usuario",
                icon: Icons.person,
                onChanged: (e) {
                  _cubit.isEnabled();
                }),
            _space(10),
            InputWidget(
                controller: _cubit.password,
                hintText: "Contraseña",
                icon: Icons.lock,
                onChanged: (e) {
                  _cubit.isEnabled();
                }),
            _space(10),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Olvide mi contraseña",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      );

  Widget _btn() => BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return BtnWidget(
              enabled: state.enabled,
              action: () async {
                if (state.enabled) {
                  final r = await _cubit.sendInfo();
                  if (r) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) => false);
                  } else {
                    alert(
                        context,
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Por favor revisa tus datos de ingreso")
                          ],
                        ), action1: () {
                      Navigator.pop(context);
                    });
                  }
                }
              },
              txt: "Ingresar");
        },
      );

  Widget _space(double space) => SizedBox(height: space);
}
