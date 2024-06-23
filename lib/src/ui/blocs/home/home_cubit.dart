
import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:acopios/src/data/repository/recolector_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _recolectorRepo = RecolectorRepo();

  HomeCubit() : super(HomeState());

  final searchTxt = TextEditingController();

  Future<List<RecolectorModel>> obtenerRecolectores() async {
    final id = await SharedPreferencesManager("id").load();
    emit(state.copyWith(loading: true, listRecolectores: []));
    final r = await _recolectorRepo.obtenerRecolectores(int.parse(id!));
    emit(state.copyWith(
        listRecolectores: r.body!, loading: false, isFilter: false));
    return r.body!;
  }

void search(String txt) {
  // Guardar la lista original si aún no está guardada
  if (state.listRecolectoresTemp == null || state.listRecolectoresTemp!.isEmpty) {
    emit(state.copyWith(listRecolectoresTemp: state.listRecolectores));
  }
  
  // Si el texto está vacío, restaurar la lista original
  if (txt.isEmpty) {
    emit(state.copyWith(listRecolectores: state.listRecolectoresTemp, isFilter: false));
    return;
  }

  // Filtrar la lista usando coincidencias aproximadas
  List<RecolectorModel> reco = state.listRecolectoresTemp!
      .where((i) {
        final lowerTxt = txt.toLowerCase();
        final lowerNombres = i.nombres?.toLowerCase() ?? "";
        final lowerApellidos = i.apellidos?.toLowerCase() ?? "";
        return lowerNombres.contains(lowerTxt) || lowerApellidos.contains(lowerTxt);
      })
      .toList();

  emit(state.copyWith(listRecolectores: reco, isFilter: true));
}


void deleteFilter() {
  searchTxt.clear();
  emit(state.copyWith(listRecolectores: state.listRecolectoresTemp, listRecolectoresTemp: [], isFilter: false));
}

}
