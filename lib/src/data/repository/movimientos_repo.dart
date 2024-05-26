import 'dart:developer';

import 'package:acopios/src/core/url.dart';
import 'package:acopios/src/data/model/movimientos_model.dart';
import 'package:dio/dio.dart';

import '../../core/shared_preferences.dart';
import '../model/response_base_model.dart';

class MovimientosRepo {
  Future<ResponseBaseModel<List<MovimientosModel>>> obtenerMovimientos(
      int id) async {
    try {
      final url = "$urlBase/compra/listar-compras-mino/$id";

      final response = await Dio().get(url,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return ResponseBaseModel<List<MovimientosModel>>(
          body: List<MovimientosModel>.from(
              response.data["body"]!.map((x) => MovimientosModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<MovimientosModel>>.fromJson({});
    }
  }
}
