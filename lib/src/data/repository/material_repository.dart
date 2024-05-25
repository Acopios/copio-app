import 'package:acopios/src/data/model/material_model.dart';
import 'package:acopios/src/data/model/precio_material.dart';
import 'package:dio/dio.dart';

import '../../core/shared_preferences.dart';
import '../../core/url.dart';
import '../model/response_base_model.dart';

class MaterialRepo {
  Future<ResponseBaseModel<List<MaterialModel>>> obtenerMateriales() async {
    try {
      const url = "$urlBase/material/listar";

      final response = await Dio().get(url,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return ResponseBaseModel<List<MaterialModel>>(
          body: List<MaterialModel>.from(
              response.data["body"]!.map((x) => MaterialModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<MaterialModel>>.fromJson({});
    }
  }

  Future<ResponseBaseModel<List<PrecioMaterial>>> obtenerPrecioMateriales(
      int idMinorista) async {
    try {
      final url = "$urlBase/material/precio/$idMinorista";

      final response = await Dio().get(url,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return ResponseBaseModel<List<PrecioMaterial>>(
          body: List<PrecioMaterial>.from(
              response.data["body"]!.map((x) => PrecioMaterial.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<PrecioMaterial>>.fromJson({});
    }
  }
}
