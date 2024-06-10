
import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/data/dto/login_dto.dart';
import 'package:acopios/src/data/repository/login_repository.dart';
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
  Future<bool> sendInfo() async {
    final r = await _repoLogin
        .login(LoginDto(usuario: user.text, contrasenia: password.text));
    if (r.success!) {
      SharedPreferencesManager("token").save(r.body!.token!);
      SharedPreferencesManager("id")
          .save(r.body!.usuario!.idUsuario!.toString());
    }
    return r.success!;
  }

  ///-----------validaciones-----------
  void isEnabled() {
    emit(state.copyWith(
        enabled: user.text.isNotEmpty && password.text.isNotEmpty));
  }

  Future<bool> isLoged() async {
    final r = await SharedPreferencesManager("token").load() ??"";

    return  r.isNotEmpty;
  }

  ///-----------otros-----------
}
