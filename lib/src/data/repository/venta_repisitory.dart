import 'package:acopios/src/core/url.dart';
import 'package:dio/dio.dart';

import '../../core/shared_preferences.dart';

class VentaRepoitory{

    Future<bool> registarVenta(List<Map<String, dynamic>> mat) async {
    try {
      const url = "$urlBase/venta/registrar";
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
}