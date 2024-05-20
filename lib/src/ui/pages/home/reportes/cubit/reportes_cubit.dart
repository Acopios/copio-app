import 'dart:developer';

import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/home/material_list/material_service.dart';
import 'package:acopios/src/ui/pages/home/material_list/materiales_model.dart';
import 'package:acopios/src/ui/pages/home/reportes/reporte_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'reportes_state.dart';

class ReportesCubit extends Cubit<ReportesState> {
  final mts = MaterialService();
  final rps = ReporteService();
  ReportesCubit() : super(ReportesState());

  BodyMaterial? materialSelected;
  bool matSeleted = false;

  final txt1 = TextEditingController();
  final txt2 = TextEditingController();
  Future<List<BodyMaterial>> obtenerMateriales() async {
    final id = await SharedPreferencesManager("idUSer").load();

    final r = await mts.obtenerMateriales(int.parse(id!));

    return r.body!;
  }

  report(int recolector) async {
    final id = await SharedPreferencesManager("idUSer").load();

    final r1 = await rps.agregarSubPrecio(data: {
      "valor": double.parse(txt1.text),
      "fechaCreacion": DateTime.now().toIso8601String(),
      "fechaActualizacion": DateTime.now().toIso8601String(),
      "idMaterial": materialSelected!.idMaterial,
      "idPrecio": materialSelected!.idPrecio,
      "idMinorista": int.parse(id!)
    });

    if (r1.success!) {
      await rps.alimenrta(data: {
        "idRecolector": recolector,
        "idMinorista": int.parse(id),
        "idMaterial": materialSelected!.idMaterial,
        "fechaAlimenta": DateTime.now().toIso8601String(),
        "valor": double.parse(txt1.text) * double.parse(txt2.text)
      });
    }
    _clear();
  }

  _clear() {
    matSeleted = false;
    txt1.clear();
    txt2.clear();
    materialSelected = null;
  }
}
