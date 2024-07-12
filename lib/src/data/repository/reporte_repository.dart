import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/core/url.dart';
import 'package:acopios/src/data/model/precio_material.dart';
import 'package:acopios/src/data/model/response_base_model.dart';
import 'package:dio/dio.dart';

class ReporteRepository {
  Future<ResponseBaseModel<List<PrecioModel>>> reporteGeneral(
      {required int id,
      required DateTime fechaI,
      required DateTime fechaF}) async {
    try {
      final url = "$urlBase/reporte/compra-general/$id";

      final response = await Dio().get(url,
          queryParameters: {
            "fechaInicio": fechaI.toIso8601String(),
            "fechaFin": fechaF.toIso8601String()
          },
          options: Options(
            headers: {
              "AUTHORIZATION":
                  "Bearer ${await SharedPreferencesManager("token").load()}"
            },
          ));

      return ResponseBaseModel<List<PrecioModel>>(
          body: List<PrecioModel>.from(
              response.data["body"]!.map((x) => PrecioModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<PrecioModel>>.fromJson({});
    }
  }

  Future<ResponseBaseModel<List<PrecioModel>>> reporteRecolector(
      {required int idRecolector,
      required DateTime fechaI,
      required DateTime fechaF}) async {
    try {
      final url = "$urlBase/reporte/compra-por-recolector/$idRecolector";

      final response = await Dio().get(url,
          queryParameters: {
            "fechaInicio": fechaI.toIso8601String(),
            "fechaFin": fechaF.toIso8601String()
          },
          options: Options(
            headers: {
              "AUTHORIZATION":
                  "Bearer ${await SharedPreferencesManager("token").load()}"
            },
          ));

      return ResponseBaseModel<List<PrecioModel>>(
          body: List<PrecioModel>.from(
              response.data["body"]!.map((x) => PrecioModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<PrecioModel>>.fromJson({});
    }
  }

  Future<ResponseBaseModel<List<PrecioModel>>> reporteGeneralVenta(
      {required DateTime fechaI,
      required DateTime fechaF,
      required int id}) async {
    try {
      final url = "$urlBase/reporte/venta-general/$id";

      final response = await Dio().get(url,
          queryParameters: {
            "fechaInicio": fechaI.toIso8601String(),
            "fechaFin": fechaF.toIso8601String()
          },
          options: Options(
            headers: {
              "AUTHORIZATION":
                  "Bearer ${await SharedPreferencesManager("token").load()}"
            },
          ));

      return ResponseBaseModel<List<PrecioModel>>(
          body: List<PrecioModel>.from(
              response.data["body"]!.map((x) => PrecioModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<PrecioModel>>.fromJson({});
    }
  }

  Future<ResponseBaseModel<List<PrecioModel>>> reporteMayorista(
      {required int idRecolector,
      required DateTime fechaI,
      required DateTime fechaF}) async {
    try {
      final url = "$urlBase/reporte/venta-por-minorista/$idRecolector";

      final response = await Dio().get(url,
          queryParameters: {
            "fechaInicio": fechaI.toIso8601String(),
            "fechaFin": fechaF.toIso8601String()
          },
          options: Options(
            headers: {
              "AUTHORIZATION":
                  "Bearer ${await SharedPreferencesManager("token").load()}"
            },
          ));

      return ResponseBaseModel<List<PrecioModel>>(
          body: List<PrecioModel>.from(
              response.data["body"]!.map((x) => PrecioModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<PrecioModel>>.fromJson({});
    }
  }

    Future<ResponseBaseModel<List<PrecioModel>>> reportReuso(
      {required int idM,
      required DateTime fechaI,
      required DateTime fechaF}) async {
    try {
      final url = "$urlBase/reporte/reuso/$idM";

      final response = await Dio().get(url,
          queryParameters: {
            "fechaInicio": fechaI.toIso8601String(),
            "fechaFin": fechaF.toIso8601String()
          },
          options: Options(
            headers: {
              "AUTHORIZATION":
                  "Bearer ${await SharedPreferencesManager("token").load()}"
            },
          ));

      return ResponseBaseModel<List<PrecioModel>>(
          body: List<PrecioModel>.from(
              response.data["body"]!.map((x) => PrecioModel.fromJson(x))),
          message: response.data["message"],
          success: response.data["success"]);
    } on DioException catch (_) {
      return ResponseBaseModel<List<PrecioModel>>.fromJson({});
    }
  }
}
