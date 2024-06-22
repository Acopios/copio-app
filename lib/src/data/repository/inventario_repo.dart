import 'package:acopios/src/core/url.dart';
import 'package:dio/dio.dart';

import '../../core/shared_preferences.dart';
import '../model/inventario_model.dart';
import '../model/response_base_model.dart';

class InventarioRepo {
  Future<ResponseBaseModel<List<InventarioModel>>> listarInventar(
      int id) async {
    try {
      final url = "$urlBase/inventario/listar/$id";

      final response = await Dio().get(url,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return ResponseBaseModel<List<InventarioModel>>(
          body: List<InventarioModel>.from(
              response.data["body"]!.map((x) => InventarioModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<InventarioModel>>.fromJson({});
    }
  }

  Future<ResponseBaseModel<List<InventarioModel>>> disponibilidad(
      List<int> ids, int id) async {
    try {
      final url = "$urlBase/inventario/disponibilidad/$id";

      final response = await Dio().post(url,
          data: {"ids": ids},
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return ResponseBaseModel<List<InventarioModel>>(
          body: List<InventarioModel>.from(
              response.data["body"]!.map((x) => InventarioModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<InventarioModel>>.fromJson({});
    }
  }
}
