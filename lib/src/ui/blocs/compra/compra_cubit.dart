import 'dart:developer';

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

  CompraCubit() : super(CompraState());

  final _materialC = MaterialCubit();
  final txt = TextEditingController();
  final txtC = TextEditingController();

  void obtenerMateriales() async {
    final list = await _materialC.obtenerMateriales(false);
    emit(state.copyWith(materiales: list));
  }

  void updateMaterial(MaterialCustom m) {
    List<MaterialCustom> mat = [];

    final list = state.materiales ?? [];
    for (var i in list) {
      if (i.idMaterial == m.idMaterial) {
        mat.add(MaterialCustom(
            idMaterial: m.idMaterial,
            valor: m.valor,
            codigo: m.codigo,
            name: m.name,
            cantidad: double.parse(txtC.text),
            valorCompra: double.parse(txt.text)));
      } else {
        mat.add(i);
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
}
