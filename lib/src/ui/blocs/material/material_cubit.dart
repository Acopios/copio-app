import 'dart:developer';

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
      this.valorCompra =0,
      this.cantidad =0,
      required this.codigo,
      required this.name});
}

class MaterialCubit extends Cubit<MaterialState> {
  final _material = MaterialRepo();
  MaterialCubit() : super(MaterialState());

  final txtPrice = TextEditingController();

Future<List<MaterialCustom>> obtenerMateriales(bool enabled) async {
      emit(state.copyWith(loading: enabled));

  List<MaterialCustom> material = [];
  final r = await _material.obtenerMateriales();
  final r2 = await _precioMateriales();

  // Crear un mapa de idMaterial a PrecioMaterial para acceso rápido
  final Map<int, PrecioMaterial> precioMap = {for (var precio in r2) precio.idMaterial!.idMaterial!: precio};

  // Iterar sobre los materiales y encontrar el precio correspondiente, si existe
  for (MaterialModel i in r.body!) {
    final precio = precioMap[i.idMaterial];
    material.add(MaterialCustom(
      idMaterial: i.idMaterial!,
      valor: precio?.valor ?? 0, // Usar el valor encontrado o 0 si no hay precio
      name: i.nombre!,
      codigo: i.codigo!,
    ));
  }
      emit(state.copyWith(loading: false));

  return material;
}


  Future<List<PrecioMaterial>> _precioMateriales() async {
    final id = await SharedPreferencesManager("id").load();
    final r = await _material.obtenerPrecioMateriales(int.parse(id!));

    return r.body!;
  }

  Future<bool> asignarPrecio(MaterialCustom m) async {
    emit(state.copyWith(loading: true));
    final id = await SharedPreferencesManager("id").load();
    final r = await _material.asignarPreci(
        dto: AsignarPrecioDto(
            idMaterial: m.idMaterial,
            idMinorista: int.parse(id!),
            fechaAsigna: DateTime.now().toIso8601String(),
            valor: double.parse(txtPrice.text)));

    emit(state.copyWith(loading: false));
    txtPrice.clear();

    return r;
  }
}
