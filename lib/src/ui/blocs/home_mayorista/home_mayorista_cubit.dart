import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/data/model/mayorista_model.dart';
import 'package:acopios/src/data/repository/mayorista_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_mayorista_state.dart';

class HomeMayoristaCubit extends Cubit<HomeMayoristaState> {
  final _mayorista = MayoristaRepository();

  HomeMayoristaCubit() : super(HomeMayoristaState());
  final txtSearch = TextEditingController();

  Future<void> obtenerMayoristas() async {
    emit(state.copyWith(loading: true));
    final id = await SharedPreferencesManager("id").load();

    final r = await _mayorista.listarMayoristas(id: int.parse(id!));
    emit(state.copyWith(loading: false, list: r.body!));
  }

  void search(String txt) {
    // Guardar la lista original si aún no está guardada
    if (state.listTemp == null || state.listTemp!.isEmpty) {
      emit(state.copyWith(listTemp: state.list));
    }
    // Si el texto está vacío, restaurar la lista original
    if (txt.isEmpty) {
      emit(state.copyWith(list: state.listTemp, isFilter: false));
      return;
    }

    // Filtrar la lista usando coincidencias aproximadas
    List<MayoristaModel> mat = state.listTemp!.where((i) {
      final lowerTxt = txt.toLowerCase();
      final lowerNombres = i.nombre!.toLowerCase();
      return lowerNombres.startsWith(lowerTxt);
    }).toList();

    emit(state.copyWith(list: mat, isFilter: true));
  }

  void deleteFilter() {
    txtSearch.clear(); // Limpiar el campo de texto de búsqueda
    // Restaurar la lista original y limpiar el estado del filtro
    emit(state.copyWith(list: state.listTemp, listTemp: [], isFilter: false));
  }

    Future<bool> eliminarMayorista(int id)async{
  emit(state.copyWith(loading: true));
  final r = await _mayorista.eliminarMayorista(id);
  emit(state.copyWith(loading: false));
  return r;

}
}
