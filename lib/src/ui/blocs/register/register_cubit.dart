import 'dart:math';

import 'package:acopios/src/data/dto/registro_dto.dart';
import 'package:acopios/src/data/repository/registro_repository.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final _repoRegister = RegistreRepository();

  final name = TextEditingController();
  final phone = TextEditingController();
  final user = TextEditingController();
  final contra = TextEditingController();
  final res = TextEditingController();
  final dic = TextEditingController();
  RegisterCubit() : super(RegisterState());

  void enabledBtn() {
    bool e = false;
    if (name.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        user.text.isNotEmpty &&
        contra.text.isNotEmpty &&
        res.text.isNotEmpty &&
        dic.text.isNotEmpty) {
      e = true;
    }
    emit(state.copyWith(enabled: e));
  }

  Future<bool> registro() async {
    emit(state.copyWith(loading: true));

    String salt= BCrypt.gensalt(logRounds: 4,prefix: "\$2a",secureRandom: Random(4));

    final String hashed = BCrypt.hashpw(contra.text, BCrypt.gensalt());

    final r = await _repoRegister.registro(RegistroDto(
      nombres: name.text,
      apellidos: "",
      estado: "activo",
      correo: user.text,
      contrasenia: hashed,
      rol: "minorista",
      direccion: dic.text,
      responsable: res.text,
      fechaCreacion: DateTime.now().toIso8601String(),
      fechaActualizacion: DateTime.now().toIso8601String(),
    ));
    emit(state.copyWith(loading: false));

    return r;
  }

  showPass(){
    emit(state.copyWith(visible: !state.visible));
  }
}
