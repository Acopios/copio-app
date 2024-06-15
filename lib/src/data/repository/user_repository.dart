import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/shared_preferences.dart';
import '../../core/url.dart';
import '../model/response_base_model.dart';
import '../model/usuario_model.dart';

class UserRepository{

  Future<ResponseBaseModel<UsuarioModel>> infoUser(
      int id) async {
    try {
      final url = "$urlBase/usuario/info/$id";

      final response = await Dio().get(url,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

   return ResponseBaseModel<UsuarioModel>(
          body: UsuarioModel.fromJson(response.data["body"]),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
log("$_" , name: "JJ");

      return ResponseBaseModel<UsuarioModel>.fromJson({});
    }
      }
}