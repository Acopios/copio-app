import 'package:acopios/src/data/model/material_model.dart';

class InventarioModel {
  final int? idInventario;
  final MaterialModel? material;
  final double? cantidad;

  InventarioModel({this.idInventario, this.material, this.cantidad});

  factory InventarioModel.fromJson(Map<String, dynamic> json) =>
      InventarioModel(
          idInventario: json["idInventario"],
          cantidad: json["cantidad"],
          material: MaterialModel.fromJson(json["material"]));
}
