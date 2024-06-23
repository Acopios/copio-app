import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:dio/dio.dart';

import '../../core/url.dart';
import '../dto/recolector_dto.dart';
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

  Future<bool> crearRecolector(RecolectorDto dto) async {
    try {
      const url = "$urlBase/usuario/crear-recolector";
      final response = await Dio().post(url,
          data: dto.toJson(),
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));
      return response.data["success"];
    } on DioException catch (_) {
      return false;
    }
  }

  Future<bool> eliminarRecolector(int id) async {
    final url = "$urlBase/usuario/desactivar-recolector/$id";
    final response = await Dio().get(url,
        options: Options(headers: {
          "AUTHORIZATION":
              "Bearer ${await SharedPreferencesManager("token").load()}"
        }));
      messageError = response.data["message"];  
    return response.data["success"];
  }
}
