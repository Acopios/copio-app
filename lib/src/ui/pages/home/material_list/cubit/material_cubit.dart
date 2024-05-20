import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/home/material_list/material_service.dart';
import 'package:acopios/src/ui/pages/home/material_list/materiales_model.dart';
import 'package:bloc/bloc.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialState> {
  final mts = MaterialService();
  MaterialCubit() : super(MaterialState());

  Future<List<BodyMaterial>> obtenerMateriales()async{
    final id = await SharedPreferencesManager("idUSer").load();

    final r = await mts.obtenerMateriales(int.parse(id!));

    return r.body!;
  }
}
