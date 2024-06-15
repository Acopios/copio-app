// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/ui/blocs/register/register_cubit.dart';
import 'package:acopios/src/ui/pages/login_page.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/btn_widget.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  late Size _size;

  final _registroC = RegisterCubit();
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => _registroC,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          title: const Text("Crear cuenta"),
        ),
        body: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return Stack(
              children: [
                _body(),
                Visibility(
                    visible: state.loading, child: const LoadingWidget()),
              ],
            );
          },
        ),
      )),
    );
  }

  Widget _body() => Container(
        margin:
            EdgeInsets.symmetric(horizontal: _size.width * .1, vertical: 30),
        child: Column(
          children: [
            _space(30),
            InputWidget(
                controller: _registroC.name,
                hintText: "Nombre Bodega",
                icon: Icons.factory,
                onChanged: (e) {
                  _registroC.enabledBtn();
                }),
            _space(10),
            InputWidget(
                controller: _registroC.phone,
                type: TextInputType.number,
                list: [FilteringTextInputFormatter.digitsOnly],
                hintText: "Número celular",
                icon: Icons.phone,
                onChanged: (e) {
                  _registroC.enabledBtn();
                }),
            _space(10),
            InputWidget(
                controller: _registroC.res,
                hintText: "Responsable",
                icon: Icons.person,
                onChanged: (e) {
                  _registroC.enabledBtn();
                }),
            _space(10),
            InputWidget(
                controller: _registroC.dic,
                hintText: "Direccion",
                icon: Icons.location_city,
                onChanged: (e) {
                  _registroC.enabledBtn();
                }),
            _space(10),
            InputWidget(
                controller: _registroC.user,
                hintText: "Usuario",
                icon: Icons.person,
                onChanged: (e) {
                  _registroC.enabledBtn();
                }),
            _space(10),
            InputWidget(
                controller: _registroC.contra,
                hintText: "Contraseña",
                icon: Icons.lock_rounded,
                onChanged: (e) {
                  _registroC.enabledBtn();
                }),
            _space(30),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return BtnWidget(
                    enabled: state.enabled,
                    action: () async {
                      final r = await _registroC.registro();
                      if (r) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()),
                            (route) => false);
                      }
                    },
                    txt: "Registrar");
              },
            ),
          ],
        ),
      );

  Widget _space(double space) => SizedBox(height: space);
}
