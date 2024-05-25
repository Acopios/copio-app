import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:dio/dio.dart';

import '../../core/url.dart';
import '../model/response_base_model.dart';

class RecolectorRepo {
  Future<ResponseBaseModel<List<RecolectorModel>>> obtenerRecolectores(
      int id) async {
    try {
      final url = "$urlBase/usuario/listar-recolectores/$id";

      final response = await Dio().get(url,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return ResponseBaseModel<List<RecolectorModel>>(
          body: List<RecolectorModel>.from(
              response.data["body"]!.map((x) => RecolectorModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<RecolectorModel>>.fromJson({});
    }
  }
}
