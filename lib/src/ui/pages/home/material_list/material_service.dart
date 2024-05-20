import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/home/material_list/materiales_model.dart';
import 'package:dio/dio.dart';

class MaterialService {
  Future<MaterialesModel> obtenerMateriales(int id) async {
    try {
      final r = await Dio().get(
          "http://localhost:8080/acopios/v1/dev/precio/minoristas/$id",
          options: Options(headers: {
            "Authorization":
                "Bearer ${await SharedPreferencesManager("token").load()}"
          }));

      return MaterialesModel.fromJson(r.data);
    } catch (e) {
      return MaterialesModel(success: false);
    }
  }
}
