import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/home/minorista/recolector.model.dart';
import 'package:acopios/src/ui/pages/home/minorista/recolectores_model.dart';
import 'package:dio/dio.dart';

class MinoristaSerice {
  Future<RecolectorModel> crearRecolector({required Map<String, dynamic> data}) async {
    try {
      final r = await Dio().post(
          "http://localhost:8080/acopios/v1/dev/minorista/crear-recolector",
          data: data,
          options: Options(headers: {
            "Authorization":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return RecolectorModel.fromJson(r.data);
    } catch (e) {
      return RecolectorModel(success: false);
    }
  }

  Future<RecolectoresModel> obtenerRecolectores(int id)async{
        try {
      final r = await Dio().get(
          "http://localhost:8080/acopios/v1/dev/minorista/recolectores/listar/$id",
          options: Options(headers: {
            "Authorization":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));
      return RecolectoresModel.fromJson(r.data);
    } catch (e) {
      return RecolectoresModel(success: false);
    }
  }
}
