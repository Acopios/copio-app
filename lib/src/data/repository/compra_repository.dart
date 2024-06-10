import 'package:acopios/src/data/model/response_base_model.dart';
import 'package:dio/dio.dart';

import '../../core/shared_preferences.dart';
import '../../core/url.dart';
import '../model/precio_material.dart';

class CompraRepo {
  Future<bool> registarCompra(List<Map<String, dynamic>> mat) async {
    try {
      const url = "$urlBase/compra/registrar";
      final response = await Dio().post(url,
          data: mat,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));
      return response.data["success"];
    } catch (e) {
      return false;
    }
  }

  Future<ResponseBaseModel<List<Precio>>> precioPorAsignacion(
      int id) async {
    try {
      final url = "$urlBase/precio/precio-reco-listar/$id";

      final response = await Dio().get(url,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return ResponseBaseModel<List<Precio>>(
          body: List<Precio>.from(
              response.data["body"]!.map((x) => Precio.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<Precio>>.fromJson({});
    }
  }
}
