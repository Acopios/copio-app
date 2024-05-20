import 'dart:developer';

import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/home/historial/alimenta_list_model.dart';
import 'package:dio/dio.dart';

class HistorialService {
  Future<AlimentaListadoResponseMondel> obtenerListado(
      {required int id}) async {
    try {
      final r = await Dio().get(
          "http://localhost:8080/acopios/v1/dev/alimenta/listar/$id",
          options: Options(headers: {
            "Authorization":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));
          log("${r.data}");

      return AlimentaListadoResponseMondel.fromJson(r.data);
    } catch (e) {
      log("$e");
      return AlimentaListadoResponseMondel(success: false);
    }
  }
}
