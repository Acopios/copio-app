import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/data/dto/crear_mayorista_dto.dart';
import 'package:acopios/src/data/repository/mayorista_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'mayorista_state.dart';

class MayoristaCubit extends Cubit<MayoristaState> {
  final _mayoristaRepo = MayoristaRepository();

  MayoristaCubit() : super(MayoristaState());

  final txt = TextEditingController();
  final nit = TextEditingController();
  final representante = TextEditingController();
  final direccion = TextEditingController();

  enbaled() {
    bool enabled = false;

    if (txt.text.isNotEmpty &&
        nit.text.isNotEmpty &&
        representante.text.isNotEmpty &&
        direccion.text.isNotEmpty) {
      enabled = true;
    }

    emit(state.copyWith(enabled: enabled));
  }

  Future<bool> crearMayorista() async {
    emit(state.copyWith(loading: true));
    final id = await SharedPreferencesManager("id").load();

    final r = await _mayoristaRepo.registarCompra(CrearMayoristaDto(
            direccion: direccion.text,
            nit: nit.text,
            representante: representante.text,
            fechaActualizacion: DateTime.now().toIso8601String(),
            fechaCreacion: DateTime.now().toIso8601String(),
            nombre: txt.text,
            idMinorista: int.parse(id!))
        .toData());
    emit(state.copyWith(loading: false));

    return r;
  }
}
