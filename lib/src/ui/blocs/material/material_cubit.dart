import 'dart:developer';

import 'package:acopios/src/data/model/material_model.dart';
import 'package:acopios/src/data/model/precio_material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/shared_preferences.dart';
import '../../../data/repository/material_repository.dart';

part 'material_state.dart';

class MaterialCustom {
  final int idMaterial;
  final double valor;
  final String name;
  final String codigo;

  MaterialCustom({
    required this.idMaterial,
    required this.valor,
    required this.codigo,
    required this.name
  });
}

class MaterialCubit extends Cubit<MaterialState> {
  final _material = MaterialRepo();
  MaterialCubit() : super(MaterialInitial());

  Future<List<MaterialCustom>> obtenerMateriales() async {
    List<MaterialCustom> material =[];
    final r = await _material.obtenerMateriales();
    final r2 = await _precioMateriales();
    for( MaterialModel i in r.body!){
       for(PrecioMaterial j  in r2){
        if(i.idMaterial==j.idMaterial!.idMaterial){
          material.add(MaterialCustom(idMaterial: i.idMaterial!, valor: j.valor!, name: i.nombre!, codigo:i.codigo!));
        }else{
           material.add(MaterialCustom(idMaterial: i.idMaterial!, valor: 0, name: i.nombre!, codigo:i.codigo!));
        }
       }

    }
    return material;
  }

  Future<List<PrecioMaterial>> _precioMateriales() async {


    final id = await SharedPreferencesManager("id").load();
    final r = await _material.obtenerPrecioMateriales(int.parse(id!));

    return r.body!;
  }
}
