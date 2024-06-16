import 'package:acopios/src/data/model/material_model.dart';
import 'package:acopios/src/data/model/mayorista_model.dart';
import 'package:acopios/src/data/repository/material_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/shared_preferences.dart';
import '../../../data/repository/venta_repisitory.dart';
import '../material/material_cubit.dart';

part 'venta_state.dart';

class VentaCubit extends Cubit<VentaState> {
  final _matC = MaterialRepo();
  final _ventaC = VentaRepoitory();
   VentaCubit() : super(VentaState());

  Future<List<MaterialModel>> obtenerMateriales() async {
    final r = await _matC.obtenerMateriales();
    return r.body!;
  }


  void updateMaterial(MaterialCustom m) {
    // Inicializa una lista vacía de materiales
    List<MaterialCustom> mat = [];

    // Obtén la lista actual de materiales desde el estado
    final list = state.materiales ?? [];

    // Si la lista está vacía, simplemente agrega el nuevo material
    if (list.isEmpty) {
      mat.add(m);
    } else {
      // Bandera para determinar si se encontró el material a actualizar
      bool materialFound = false;

      // Recorre cada material en la lista actual
      for (var i in list) {
        if (i.idMaterial == m.idMaterial) {
          // Si el idMaterial coincide, reemplaza el material existente
          mat.add(MaterialCustom(
              idMaterial: m.idMaterial,
              valor: m.valor,
              codigo: m.codigo,
              name: m.name,
              cantidad: m.cantidad,
              valorCompra: m.valorCompra));
          materialFound = true;
        } else {
          // Si el idMaterial no coincide, agrega el material existente sin cambios
          mat.add(i);
        }
      }
      // Si no se encontró el material en la lista, se agrega el nuevo material
      if (!materialFound) {
        mat.add(m);
      }
    }
    emit(state.copyWith(materiales: mat));
  }

    Future<List<Map<String, dynamic>>> registrarVenta(MayoristaModel r) async {
    final id = await SharedPreferencesManager("id").load();

    List<Map<String, dynamic>> data = [];
    for (var i in state.materiales!) {
      if (i.cantidad > 0) {
        data.add({
          "idMayorista": r.idMayorista,
          "idMinorista": int.parse(id!),
          "idMaterial": i.idMaterial,
          "fechaAlimenta": DateTime.now().toIso8601String(),
          "cantidad": i.cantidad,
          "precioUnidad": i.valorCompra,
          "total": i.cantidad * i.valorCompra,
          "material": i.name,
          "valor": i.valor
        });
      }
    }

    return data;
  }
 Future<bool> realizarCompra(List<Map<String, dynamic>> data) async {
    final r = await _ventaC.registarVenta(data);
    return r;
  }
}
