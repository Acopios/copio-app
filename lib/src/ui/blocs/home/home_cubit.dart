
import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:acopios/src/data/repository/recolector_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _recolectorRepo = RecolectorRepo();

  HomeCubit() : super(HomeInitial());

  Future<List<RecolectorModel>> obtenerRecolectores() async {
    final id = await SharedPreferencesManager("id").load();
    final r = await _recolectorRepo.obtenerRecolectores(int.parse(id!));
    return r.body!;
  }
}
