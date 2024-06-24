import 'package:acopios/src/data/repository/reuso_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_preferences.dart';
import '../../../data/model/inventario_model.dart';
import '../../../data/model/material_model.dart';
import '../../../data/repository/inventario_repo.dart';
import '../../../data/repository/material_repository.dart';
import '../material/material_cubit.dart';

part 'reuso_state.dart';

class ReusoCubit extends Cubit<ReusoState> {
  final _matC = MaterialRepo();
  final _inven = InventarioRepo();
  final _reusoC = ReusoRepo();

  ReusoCubit() : super(ReusoState());

  final txtSearch = TextEditingController();
  List<int> ids = [];
  List<InventarioModel> l = [];

  Future<void> obtenerMateriales() async {
    emit(state.copyWith(loading: true));
    final r = await _matC.obtenerMateriales();
    ids = [];

    for (var i in r.body!) {
      ids.add(i.idMaterial!);
    }
    await disponibilidad();
    emit(state.copyWith(list: r.body!, loading: false));
  }

  Future<void> disponibilidad() async {
    final id = await SharedPreferencesManager("id").load();
    l = [];
    final r = await _inven.disponibilidad(ids, int.parse(id!));

    l = r.body!;
  }

  Future<double> cantidad(int id) async {
    final r = l
            .firstWhere((element) => element.material?.idMaterial == id,
                orElse: () => InventarioModel(
                    material: MaterialModel(idMaterial: id),
                    cantidad: 0) // Replace with an appropriate default instance
                )
            .cantidad ??
        0;

    return r;
  }

  void updateMaterial(MaterialCustom m) {
    // Inicializa una lista vacía de materiales
    List<MaterialCustom> mat = [];

    // Obtén la lista actual de materiales desde el estado
    final list = state.materiales ?? [];

    // Si la lista está vacía, simplemente agrega el nuevo material
    if (list.isEmpty) {
      mat.add(m);
    } else {
      // Bandera para determinar si se encontró el material a actualizar
      bool materialFound = false;

      // Recorre cada material en la lista actual
      for (var i in list) {
        if (i.idMaterial == m.idMaterial) {
          // Si el idMaterial coincide, reemplaza el material existente
          mat.add(MaterialCustom(
              idMaterial: m.idMaterial,
              valor: m.valor,
              codigo: m.codigo,
              name: m.name,
              cantidad: m.cantidad,
              valorCompra: m.valorCompra));
          materialFound = true;
        } else {
          // Si el idMaterial no coincide, agrega el material existente sin cambios
          mat.add(i);
        }
      }
      // Si no se encontró el material en la lista, se agrega el nuevo material
      if (!materialFound) {
        mat.add(m);
      }
    }
    emit(state.copyWith(materiales: mat));
  }

  void search(String txt) {
    // Guardar la lista original si aún no está guardada
    if (state.listTem == null || state.listTem!.isEmpty) {
      emit(state.copyWith(listTem: state.list));
    }
    // Si el texto está vacío, restaurar la lista original
    if (txt.isEmpty) {
      emit(state.copyWith(list: state.listTem, isFilter: false));
      return;
    }

    // Filtrar la lista usando coincidencias aproximadas
    List<MaterialModel> mat = state.listTem!.where((i) {
      final lowerTxt = txt.toLowerCase();
      final lowerNombres = i.nombre!.toLowerCase();
      return lowerNombres.startsWith(lowerTxt);
    }).toList();

    emit(state.copyWith(list: mat, isFilter: true));
  }

  void deleteFilter() {
    txtSearch.clear(); // Limpiar el campo de texto de búsqueda
    // Restaurar la lista original y limpiar el estado del filtro
    emit(state.copyWith(list: state.listTem, listTem: [], isFilter: false));
  }

    Future<List<Map<String, dynamic>>> registrarVenta() async {
    final id = await SharedPreferencesManager("id").load();

    List<Map<String, dynamic>> data = [];
    for (var i in state.materiales!) {
      if (i.cantidad > 0) {
        data.add({
          "idMinorista": int.parse(id!),
          "idMaterial": i.idMaterial,
          "fechaCreacion": DateTime.now().toIso8601String(),
          "fechaActualizacion": DateTime.now().toIso8601String(),
          "cantidad": i.cantidad,
          "valor": i.valorCompra,
          "total": i.cantidad * i.valorCompra,
          "material": i.name,
        });
      }
    }

    return data;
  }

  Future<bool> registrarReuso(List<Map<String, dynamic>> data) async {
    final r = await _reusoC.registarReuso(data);
    return r;
  }
}
