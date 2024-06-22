
import 'package:acopios/src/core/url.dart';
import 'package:acopios/src/data/dto/registro_dto.dart';
import 'package:dio/dio.dart';

import '../../core/utils.dart';

class RegistreRepository {
  Future<bool> registro(RegistroDto dto) async {
    try {
      const url = "$urlBase/usuario/crear";
      final response = await Dio().post(url, data: dto.toJson());
      return response.data["success"];
    } on DioException catch (_, __) {
      messageError = _.response!.data["body"]["message"];
      return false;
    }
  }
}
