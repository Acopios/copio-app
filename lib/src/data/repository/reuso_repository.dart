import 'package:dio/dio.dart';

import '../../core/shared_preferences.dart';
import '../../core/url.dart';

class ReusoRepo{


    Future<bool> registarReuso(List<Map<String, dynamic>> mat) async {
    try {
      const url = "$urlBase/reuso/crear";
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