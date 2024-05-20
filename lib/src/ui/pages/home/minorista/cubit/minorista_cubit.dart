import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/home/minorista/minorita_service.dart';
import 'package:acopios/src/ui/pages/home/minorista/recolector.model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'minorista_state.dart';

class MinoristaCubit extends Cubit<MinoristaState> {

  final mis = MinoristaSerice();
  MinoristaCubit() : super(MinoristaState());

  final txt1 = TextEditingController();
  final txt2 = TextEditingController();
  final txt3 = TextEditingController();


  Future<RecolectorModel> crearReclector()async{
final id =await SharedPreferencesManager("idUSer").load();
    return await mis.crearRecolector(data: {
    "nombres":txt1.text,
    "apellidos": txt2.text,
    "identificacion": txt3.text,
    "fechaMacimiento":  DateTime.now().toIso8601String(),
    "estado": "activo",
    "fechaCreacion":  DateTime.now().toIso8601String(),
    "fechaActualizacion": DateTime.now().toIso8601String(),
    "idMinorista": int.parse(id!)
    });
  
  }
}
