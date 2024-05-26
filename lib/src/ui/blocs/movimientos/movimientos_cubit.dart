import 'dart:developer';

import 'package:acopios/src/data/model/movimientos_model.dart';
import 'package:acopios/src/data/repository/movimientos_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/shared_preferences.dart';

part 'movimientos_state.dart';

class MovimientosCubit extends Cubit<MovimientosState> {
  final _movimientoRepo = MovimientosRepo();

  MovimientosCubit() : super(MovimientosInitial());

  Future<List<MovimientosModel>> obtenerMovimientos() async {
    final id = await SharedPreferencesManager("id").load();

    log("$id");
    final r = await _movimientoRepo.obtenerMovimientos(int.parse(id!));

    return r.body!;
  }

  Future<List<double>> caluculo(List<Compra> c) async {
    double kilos = 0;
    double valorPagado = 0;

    for (var i in c) {
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
        "precioUnidad": i.total,
        "total": i.total!,
        "material": i.idMaterial!.nombre,
      });
    }

    return data;
  }
}
