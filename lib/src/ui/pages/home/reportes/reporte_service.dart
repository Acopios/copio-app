import 'dart:developer';

import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/home/reportes/alimenta_response_model.dart';
import 'package:acopios/src/ui/pages/home/reportes/sub_precio_response_model.dart';
import 'package:dio/dio.dart';

class ReporteService{



  Future<SubPrecioResponseModel> agregarSubPrecio({required Map<String, dynamic> data})async{
  try {
      final r = await Dio().post(
          "http://localhost:8080/acopios/v1/dev/subprecio/agregar",
          data: data,
          options: Options(headers: {
            "Authorization":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return SubPrecioResponseModel.fromJson(r.data);
    } catch (e) {
      log("$e --1");
      return SubPrecioResponseModel(success: false);
    }
  }

  Future<AlimentaResponseMondel> alimenrta({required Map<String, dynamic> data})async{
  try {
      final r = await Dio().post(
          "http://localhost:8080/acopios/v1/dev/alimenta/agrega",
          data: data,
          options: Options(headers: {
            "Authorization":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return AlimentaResponseMondel.fromJson(r.data);
    } catch (e) {
      log("$e -->");
      return AlimentaResponseMondel(success: false);
    }
  }
}