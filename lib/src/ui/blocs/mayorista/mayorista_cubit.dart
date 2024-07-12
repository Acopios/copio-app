import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/data/dto/crear_mayorista_dto.dart';
import 'package:acopios/src/data/model/mayorista_model.dart';
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
  final email = TextEditingController();
  final telefono = TextEditingController();

  enbaled() {
    bool enabled = false;

    if (txt.text.isNotEmpty &&
        nit.text.isNotEmpty &&
        representante.text.isNotEmpty &&
        email.text.isNotEmpty &&
        telefono.text.isNotEmpty &&
        direccion.text.isNotEmpty) {
      enabled = true;
    }

    emit(state.copyWith(enabled: enabled));
  }

  Future<bool> crearMayorista({bool edit=false, int? idM}) async {
    emit(state.copyWith(loading: true));
    final id = await SharedPreferencesManager("id").load();

    final r = await _mayoristaRepo.crearM(CrearMayoristaDto(
            direccion: direccion.text,
            nit: nit.text,
            telefono: telefono.text,
            correo: email.text,
            idMayorista: edit?idM:null,
            representante: representante.text,
            fechaActualizacion: DateTime.now().toIso8601String(),
            fechaCreacion: DateTime.now().toIso8601String(),
            nombre: txt.text,
            idMinorista: int.parse(id!))
        .toData());
    emit(state.copyWith(loading: false));

    return r;
  }

initDataEdit(MayoristaModel m){
  txt.text = m.nombre!;
  nit.text = m.nit!;
  representante.text = m.representante!;
  direccion.text = m.representante!;

  emit(state.copyWith(enabled: true));
}
}
