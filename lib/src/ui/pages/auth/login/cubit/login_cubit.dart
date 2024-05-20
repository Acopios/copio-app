import 'dart:developer';

import 'package:acopios/src/ui/pages/auth/login_model.dart';
import 'package:acopios/src/ui/pages/auth/service_login.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final loginSevice = ServiceLogin();
  LoginCubit() : super(LoginState());

  final txtUser = TextEditingController();
  final txtPassword = TextEditingController();

  Future<Loginmodel> sendinfo() async{
   return await loginSevice.login(user: txtUser.text, pass: txtPassword.text);
  }
}
