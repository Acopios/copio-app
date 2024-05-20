import 'package:acopios/src/ui/pages/auth/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormLogin extends StatelessWidget {
  FormLogin({super.key});

  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return _bodyForm();
  }

  Widget _bodyForm() => BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final c = context.read<LoginCubit>();
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: _size.width * .1, vertical: _size.height * .05),
            child: Column(
              children: [
                _input(iconData: Icons.person_4_sharp, txtHelper: "Usuario", onChanged: (e){}, txt: c.txtUser),
                const SizedBox(height: 10),
                _input(iconData: Icons.lock_outline, txtHelper: "Contraseña", onChanged: (e){}, txt: c.txtPassword),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "olvide mi contraseña.",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );

  Widget _input(
          {required String txtHelper,
          required IconData iconData,
          required TextEditingController txt,
          required Function(dynamic e) onChanged}) =>
      TextField(
        controller: txt,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: txtHelper,
          prefixIcon: Icon(iconData),
          contentPadding: const EdgeInsets.all(0),
          border: const OutlineInputBorder(),
        ),
      );
}
