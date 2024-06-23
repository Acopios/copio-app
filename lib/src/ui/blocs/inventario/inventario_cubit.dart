import 'dart:developer';

import 'package:acopios/src/data/model/inventario_model.dart';
import 'package:acopios/src/data/model/movimientos_model.dart';
import 'package:acopios/src/data/repository/inventario_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_preferences.dart';

part 'inventario_state.dart';

class InventarioCubit extends Cubit<InventarioState> {
  final _movimientoRepo = InventarioRepo();

  InventarioCubit() : super( InventarioState());

  final txtSearch = TextEditingController();

  Future<void> listarInventar() async {
    emit(state.copyWith(loading: true));
    final id = await SharedPreferencesManager("id").load();

    final r = await _movimientoRepo.listarInventar(int.parse(id!));
    emit(state.copyWith(loading: false, list: r.body!));

  }

  Future<List<double>> caluculo(List<Compra> c) async {
    double kilos = 0;
    double valorPagado = 0;

    for (var i in c) {
      log("${i.toJson()}");
      kilos += i.cantidad!;
      valorPagado += i.total!;
    }

    return [kilos, valorPagado];
  }

  Future<List<Map<String, dynamic>>> toData(List<Compra> c) async {
    List<Map<String, dynamic>> data = [];
    for (var i in c) {
      data.add({
        "idMaterial": i.idMaterial,
        "fechaAlimenta": DateTime.now().toIso8601String(),
        "cantidad": i.cantidad,
        "precioUnidad": i.precioUnidad,
        "total": i.total!,
        "material": i.idMaterial!.nombre,
      });
    }

    return data;
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
    List<InventarioModel> mat = state.listTemp!.where((i) {
      final lowerTxt = txt.toLowerCase();
      final lowerNombres = i.material!.nombre!.toLowerCase();
      return lowerNombres.startsWith(lowerTxt);
    }).toList();

    emit(state.copyWith(list: mat, isFilter: true));
  }

  void deleteFilter() {
    txtSearch.clear(); // Limpiar el campo de texto de búsqueda
    // Restaurar la lista original y limpiar el estado del filtro
    emit(state.copyWith(list: state.listTemp, listTemp: [], isFilter: false));
  }
}
