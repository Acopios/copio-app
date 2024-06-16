import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/data/model/mayorista_model.dart';
import 'package:acopios/src/data/repository/mayorista_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_mayorista_state.dart';

class HomeMayoristaCubit extends Cubit<HomeMayoristaState> {
  final _mayorista = MayoristaRepository();

  HomeMayoristaCubit() : super(HomeMayoristaInitial());

  Future<List<MayoristaModel>> obtenerMayoristas() async {
    final id = await SharedPreferencesManager("id").load();

    final r = await _mayorista.listarMayoristas(id: int.parse(id!));

    return r.body!;
  }
}
