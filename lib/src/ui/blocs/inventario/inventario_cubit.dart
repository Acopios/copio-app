import 'dart:developer';

import 'package:acopios/src/data/model/inventario_model.dart';
import 'package:acopios/src/data/model/movimientos_model.dart';
import 'package:acopios/src/data/repository/inventario_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/shared_preferences.dart';

part 'inventario_state.dart';

class InventarioCubit extends Cubit<InventarioState> {
  final _movimientoRepo = InventarioRepo();

  InventarioCubit() : super(const InventarioState());

  Future<List<InventarioModel>> listarInventar() async {
    final id = await SharedPreferencesManager("id").load();

    final r = await _movimientoRepo.listarInventar(int.parse(id!));

    return r.body!;
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
}
