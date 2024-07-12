import 'package:acopios/src/data/dto/asignar_precio_dto.dart';
import 'package:acopios/src/data/model/material_model.dart';
import 'package:acopios/src/data/model/precio_material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_preferences.dart';
import '../../../data/repository/material_repository.dart';

part 'material_state.dart';

class MaterialCustom {
  final int idMaterial;
  final double valor;
  final double valorCompra;
  final String name;
  final String codigo;
  final double cantidad;

  MaterialCustom(
      {required this.idMaterial,
      required this.valor,
      this.valorCompra = 0,
      this.cantidad = 0,
      required this.codigo,
      required this.name});
}

class MaterialCubit extends Cubit<MaterialState> {
  final _material = MaterialRepo();
  MaterialCubit() : super(MaterialState());

  final txtPrice = TextEditingController();
  final txtSearch = TextEditingController();

  Future<void> obtenerMateriales(bool enabled) async {
    emit(state.copyWith(loading: true));
    final r = await _material.obtenerMateriales();

    emit(state.copyWith(loading: false, list: r.body));
  }

  Future<List<PrecioMaterial>> precioMateriales() async {
    final id = await SharedPreferencesManager("id").load();
    final r = await _material.obtenerPrecioMateriales(int.parse(id!));

    return r.body ?? [];
  }

  Future<bool> asignarPrecio(MaterialModel m, int idA, String precio) async {
    emit(state.copyWith(loading: true));
    final id = await SharedPreferencesManager("id").load();
    final r = await _material.asignarPreci(
        dto: AsignarPrecioDto(
            idAsignacion: idA + 1,
            idMaterial: m.idMaterial!,
            idMinorista: int.parse(id!),
            fechaAsigna: DateTime.now().toIso8601String(),
            valor: double.parse(precio)));

    emit(state.copyWith(loading: false));
    txtPrice.clear();

    return r;
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
    List<MaterialModel> mat = state.listTemp!.where((i) {
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

 
}
