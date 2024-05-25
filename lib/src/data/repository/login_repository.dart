
import 'package:dio/dio.dart';

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
      return ResponseBaseModel<LoginModel>.fromJson({});
    }
  }
}
