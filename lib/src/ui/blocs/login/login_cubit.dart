import 'dart:developer';

import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/data/dto/login_dto.dart';
import 'package:acopios/src/data/repository/login_repository.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  ///-----------repositorio-----------
  final _repoLogin = LoginRepository();

  ///-----------constructor-----------

  LoginCubit() : super(LoginState());

  ///-----------variables-----------

  final user = TextEditingController();
  final password = TextEditingController();

  ///-----------eventos-----------

  ///-----------peticiones-----------
  Future<String> sendInfo() async {
    final r = await _repoLogin
        .login(LoginDto(usuario: user.text, contrasenia: password.text));
    if (r.success!) {
      SharedPreferencesManager("token").save(r.body!.token!);
      SharedPreferencesManager("id")
          .save(r.body!.usuario!.idUsuario!.toString());
    }
    return r.success! ? r.body!.usuario!.estado! : "";
  }

  ///-----------validaciones-----------
  void isEnabled() {
    emit(state.copyWith(
        enabled: user.text.isNotEmpty && password.text.isNotEmpty));
  }

  Future<bool> isLoged() async {
    final r = await SharedPreferencesManager("token").load() ?? "";

    return r.isNotEmpty;
  }

  void showPass() {
    emit(state.copyWith(visible: !state.visible));
  }

  Future<bool> recuperar(String txt1, String tx2) async {
    return await _repoLogin.recuperar({
      "usuario": txt1,
      "contrasenia": BCrypt.hashpw(tx2, BCrypt.gensalt()),
      "fechaActualizacion": DateTime.now().toIso8601String()
    });
  }

  Future<bool> activar(String txt1, String tx2) async {

log(tx2, name: "de");
final has = BCrypt.hashpw(tx2, BCrypt.gensalt());
    final r = await _repoLogin.activarUsuario({
      "user": txt1,
      "idUsuario":await SharedPreferencesManager("id").load(),
      "passV": "",
      "passN": has,
      "fechaActualizacion": DateTime.now().toIso8601String()
    });
    await SharedPreferencesManager("id").remove();
    await SharedPreferencesManager("token").remove();
    return r ;
  }

  ///-----------otros-----------
}
