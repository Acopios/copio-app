import 'package:acopios/src/data/model/precio_material.dart';
import 'package:acopios/src/data/repository/compra_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_preferences.dart';
import '../../../data/model/recolector_model.dart';
import '../material/material_cubit.dart';

part 'compra_state.dart';

class CompraCubit extends Cubit<CompraState> {
  final _compraRepor = CompraRepo();

  CompraCubit() : super( CompraState());

  final txt = TextEditingController();
  final txtC = TextEditingController();
  final searchTxt = TextEditingController();

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

  Future<List<Map<String, dynamic>>> registrarCompra(RecolectorModel r) async {
    final id = await SharedPreferencesManager("id").load();

    List<Map<String, dynamic>> data = [];
    for (var i in state.materiales!) {
      if (i.cantidad > 0) {
        data.add({
          "idRecolector": r.idRecolector,
          "idMinorista": int.parse(id!),
          "idMaterial": i.idMaterial,
          "fechaAlimenta": DateTime.now().toIso8601String(),
          "cantidad": i.cantidad,
          "precioUnidad": i.valorCompra,
          "total": i.cantidad * i.valorCompra,
          "material": i.name,
          "valor": i.valor
        });
      }
    }

    return data;
  }

  Future<bool> realizarCompra(List<Map<String, dynamic>> data) async {
    final r = await _compraRepor.registarCompra(data);

    return r;
  }

  Future<List<PrecioModel>> precioAsignacion(int id) async {
    emit(state.copyWith(loading: true, precios: []));
        final idM = await SharedPreferencesManager("id").load();
    final r = await _compraRepor.precioPorAsignacion(id, int.parse(idM!));
    emit(state.copyWith(loading: false, isFilter: false,precios: r.body ?? []));
    return r.body!;
  }

void search(String txt) {
  // Guardar la lista original si aún no está guardada
  if (state.preciosTemp == null || state.preciosTemp!.isEmpty) {
    emit(state.copyWith(preciosTemp: state.precios));
  }
  
  // Si el texto está vacío, restaurar la lista original
  if (txt.isEmpty) {
    emit(state.copyWith(precios: state.preciosTemp, isFilter: false));
    return;
  }

  // Filtrar la lista usando coincidencias aproximadas
  List<PrecioModel> reco = state.preciosTemp!
      .where((i) {
        final lowerTxt = txt.toLowerCase();
        final lowerNombres = i.idMaterial.nombre.toLowerCase();
        return lowerNombres.startsWith(lowerTxt);
      })
      .toList();

  emit(state.copyWith(precios: reco, isFilter: true));
}


void deleteFilter() {
  searchTxt.clear();
  emit(state.copyWith(precios: state.preciosTemp, preciosTemp: [], isFilter: false));
}
}
