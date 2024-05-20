import 'dart:developer';

import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/auth/login/cubit/login_cubit.dart';
import 'package:acopios/src/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtnLogin extends StatelessWidget {
  BtnLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final c = context.read<LoginCubit>();

        return ElevatedButton(
            onPressed: () async {
              final r = await c.sendinfo();
              log("${r.success}");
              if (r.success) {
                SharedPreferencesManager("token").save(r.body.token);
                SharedPreferencesManager("idUSer").save(r.body.usuario!.idUsuario.toString());
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Por favor revisa tus credenciales"),
                ));
              }
            },
            child: const Text("Ingresar"));
      },
    );
  }
}
