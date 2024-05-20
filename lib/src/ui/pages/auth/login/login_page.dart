import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/auth/login/cubit/login_cubit.dart';
import 'package:acopios/src/ui/pages/auth/login/views/btn_login.dart';
import 'package:acopios/src/ui/pages/auth/login/views/form_login.dart';
import 'package:acopios/src/ui/pages/auth/login/views/logo_view.dart';
import 'package:acopios/src/ui/pages/auth/login/views/txt_loging.dart';
import 'package:acopios/src/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final r = await SharedPreferencesManager("token").load();
    if (r!.isNotEmpty) {
        Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _body(),
    ));
  }

  Widget _body() => BlocProvider(
        create: (context) => LoginCubit(),
        child: Column(
          children: [LogoView(), TextLogin(), FormLogin(), BtnLogin()],
        ),
      );
}
