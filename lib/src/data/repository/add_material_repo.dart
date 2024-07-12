import 'package:acopios/src/core/url.dart';
import 'package:dio/dio.dart';

import '../../core/shared_preferences.dart';

class AddMaterialRepo {
  Future<bool> addMaterial(List<Map<String, dynamic>> mat) async {
    try {
      const url = "$urlBase/inventario/crear";
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
