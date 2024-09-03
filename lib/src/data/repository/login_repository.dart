import 'dart:developer';

import 'package:acopios/src/core/utils.dart';
import 'package:dio/dio.dart';

import '../../core/shared_preferences.dart';
import '../../core/url.dart';
import '../dto/login_dto.dart';
import '../model/login_model.dart';
import '../model/response_base_model.dart';

class LoginRepository {
  Future<ResponseBaseModel<LoginModel>> login(LoginDto dto) async {
    try {
      const url = "$urlBase/autenticacion/login";
      final response = await Dio().post(url, data: dto.toJson());

      return ResponseBaseModel<LoginModel>(
          body: LoginModel.fromJson(response.data["body"]),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      messageError = _.response!.data["body"]["message"];
      return ResponseBaseModel<LoginModel>.fromJson({});
    }
  }

  Future<bool> recuperar(Map<String, dynamic> dto) async {
    try {
      const url = "$urlBase/autenticacion/recuperar";
      final response = await Dio().post(url, data: dto);
      log("$response");
      return response.data["success"];
    } on DioException catch (_) {
      messageError = _.response!.data["body"]["message"];
      return false;
    }
  }

  Future<bool> activarUsuario(Map<String, dynamic> dto) async {
    try {
      const url = "$urlBase/usuario/activar-usuario";
      final response = await Dio().post(url,
          data: dto,
          options: Options(headers: {
            "AUTHORIZATION":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));
      log("$response");
      return response.data["success"];
    } on DioException catch (_) {
      messageError = _.response!.data["body"]["message"];
      return false;
    }
  }
}
