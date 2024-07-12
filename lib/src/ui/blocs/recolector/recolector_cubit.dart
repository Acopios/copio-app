import 'package:acopios/src/data/dto/recolector_dto.dart';
import 'package:acopios/src/data/repository/recolector_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_preferences.dart';
import '../../../data/model/recolector_model.dart';

part 'recolector_state.dart';

class RecolectorCubit extends Cubit<RecolectorState> {
  final _recolectorRepo = RecolectorRepo();

  RecolectorCubit() : super(RecolectorState());

  final name = TextEditingController();
  final lastname = TextEditingController();
  final ide = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final lsita = TextEditingController();
  int idLista =0;

  Future<bool> crearRecolector({bool edit =false, int? idR}) async {
    emit(state.copyWith(loading: true));

    final id = await SharedPreferencesManager("id").load();

    final r = await _recolectorRepo.crearRecolector(RecolectorDto(
      nombres: name.text,
      idRecolector: edit?idR:null,
      apellidos: lastname.text,
      direccion: address.text,
      idListaPrecios: idLista,
      telefono: phone.text,
      identificacion: ide.text,
      idMinorista: int.parse(id!),
    ));
    emit(state.copyWith(loading: false));
    return r;
  }

  void isEnabled() {
    bool e = false;

    if (name.text.isNotEmpty &&
        lastname.text.isNotEmpty &&
        address.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        idLista!=0 &&
        ide.text.isNotEmpty) {
      e = true;
    }
    emit(state.copyWith(enabled: e));
  }

   addDataEdi(RecolectorModel r) {
    name.text = r.nombres!;
    lastname.text = r.apellidos!;
    ide.text = r.identificacion!;
    address.text = r.direccion!;
    phone.text = r.telefono!;
    idLista = r.idListaPrecios!;
    lsita.text = "Lista de precio ${r.idListaPrecios!}";
   emit(state.copyWith(enabled: true));
   }
}
