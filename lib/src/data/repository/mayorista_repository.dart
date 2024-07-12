import 'package:acopios/src/data/model/mayorista_model.dart';
import 'package:dio/dio.dart';

import '../../core/shared_preferences.dart';
import '../../core/url.dart';
import '../../core/utils.dart';
import '../model/response_base_model.dart';

class MayoristaRepository {
  Future<bool> crearM(Map<String, dynamic> data) async {
    try {
      const url = "$urlBase/mayorista/crear";
      final response = await Dio().post(url,
          data: data,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));
      return response.data["success"];
    } on DioException catch (_)  {
        messageError = _.response!.data["body"]["message"];
      return false;
    }
  }

  Future<ResponseBaseModel<List<MayoristaModel>>> listarMayoristas({
    required int id,
  }) async {
    try {
      final url = "$urlBase/mayorista/listar/$id";

      final response = await Dio().get(url,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return ResponseBaseModel<List<MayoristaModel>>(
          body: List<MayoristaModel>.from(
              response.data["body"]!.map((x) => MayoristaModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<MayoristaModel>>.fromJson({});
    }
  }
    Future<bool> eliminarMayorista(int id) async {
    final url = "$urlBase/mayorista/desactivar-mayorista/$id";
    final response = await Dio().get(url,
        options: Options(headers: {
          "AUTHORIZATION":
              "Bearer ${await SharedPreferencesManager("token").load()}"
        }));
      messageError = response.data["message"];  
    return response.data["success"];
  }
}
