import 'dart:developer';

import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/data/model/precio_material.dart';
import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:acopios/src/data/repository/recolector_repository.dart';
import 'package:acopios/src/data/repository/reporte_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';

import '../../../data/repository/user_repository.dart';

part 'reporte_state.dart';

class ReporteCubit extends Cubit<ReporteState> {
  final _reporteR = ReporteRepository();
  final _userRepo = UserRepository();
  final _recolectoRepo = RecolectorRepo();

  ReporteCubit() : super(ReporteState());

  addFechaI(DateTime fecha) {
    emit(state.copyWith(fechaI: fecha));
  }

  addFechaF(DateTime fecha) {
    emit(state.copyWith(fechaF: fecha));
  }

  showDate(bool value) {
    emit(state.copyWith(showDate: value));
  }

  Future<void> obtenerReporte() async {
    emit(state.copyWith(loadingReport: true));
    final r = await _reporteR.reporteGeneral(
        fechaI: state.fechaI!, fechaF: state.fechaF!);

    emit(state.copyWith(list: r.body, loadingReport: false));
  }

  Future<void> obtenerReporteIdividual(int id) async {
    emit(state.copyWith(loadingReport: true));

    final r = await _reporteR.reporteRecolector(
        idRecolector: id, fechaI: state.fechaI!, fechaF: state.fechaF!);

    emit(state.copyWith(list: r.body, loadingReport: false));
  }

  obtenerRecolectores() async {
    emit(state.copyWith(loadingReport: true));
    final id = await SharedPreferencesManager("id").load();
    final r = await _recolectoRepo.obtenerRecolectores(int.parse(id!));
    emit(state
        .copyWith(loadingReport: false, listRecolectores: r.body!, list: []));
  }

  Future<bool> crearReporteGeneral() async {
    emit(state.copyWith(loadingReport: true));

    final idUser = await SharedPreferencesManager("id").load();

    final user = await _userRepo.infoUser(int.parse(idUser!));
    final list = state.list;
    List<CellValue> col = const [
      TextCellValue("Recolector"),
      TextCellValue("Identificacion Recolector"),
      TextCellValue("Material"),
      TextCellValue("Codigo"),
      TextCellValue("Fecha Ingreso"),
      TextCellValue("Cantidad"),
      TextCellValue("Precio Unidad"),
      TextCellValue("Total")
    ];

    List<Map<String, dynamic>> userData = [
      {"name": "Nombre", "value": user.body!.nombre! + user.body!.apellidos!},
      {"name": "Correo", "value": user.body!.correo!},
      {"name": "Responsable", "value": user.body!.responsable!},
      {"name": "Direccion", "value": user.body!.direccion!},
    ];
    List<List<TextCellValue>> body = [];

    for (var i in list!) {
      body.add([
        TextCellValue(i.recolectorModel!.nombres!),
        TextCellValue(i.recolectorModel!.identificacion!),
        TextCellValue(i.idMaterial.nombre),
        TextCellValue(i.idMaterial.codigo),
        TextCellValue(i.fechaAlimenta!.toIso8601String()),
        TextCellValue(i.cantidad.toString()),
        TextCellValue(i.precioUnidad.toString()),
        TextCellValue(i.total.toString())
      ]);
    }
    try {
      await crearExcel(columnas: col, userData: userData, body: body);
      emit(state.copyWith(loadingReport: false));

      return true;
    } catch (e) {
      emit(state.copyWith(loadingReport: false));

      return false;
    }
  }

  Future<bool> crearReporteInividual(RecolectorModel recolectorModel) async {
    emit(state.copyWith(loadingReport: true));

    final list = state.list;
    List<CellValue> col = const [
      TextCellValue("Material"),
      TextCellValue("Codigo"),
      TextCellValue("Fecha Ingreso"),
      TextCellValue("Cantidad"),
      TextCellValue("Precio Unidad"),
      TextCellValue("Total")
    ];

    List<Map<String, dynamic>> userData = [
      {
        "name": "Nombre",
        "value": recolectorModel.nombres! + recolectorModel.apellidos!
      },
      {"name": "Identificacion", "value": recolectorModel.identificacion!},
      {"name": "Telefono", "value": recolectorModel.telefono!},
    ];
    List<List<TextCellValue>> body = [];

    for (var i in list!) {
      body.add([
        TextCellValue(i.idMaterial.nombre),
        TextCellValue(i.idMaterial.codigo),
        TextCellValue(i.fechaAlimenta!.toIso8601String()),
        TextCellValue(i.cantidad.toString()),
        TextCellValue(i.precioUnidad.toString()),
        TextCellValue(i.total.toString())
      ]);
    }
    try {
      await crearExcel(columnas: col, userData: userData, body: body);
      emit(state.copyWith(loadingReport: false));

      return true;
    } catch (e) {
      emit(state.copyWith(loadingReport: false));

      return false;
    }
  }

  clearR2() {
    emit(state.copyWith(listRecolectores: []));
  }
}
