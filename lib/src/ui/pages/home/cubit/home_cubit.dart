import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/home/minorista/minorita_service.dart';
import 'package:acopios/src/ui/pages/home/minorista/recolectores_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final mis = MinoristaSerice();

  HomeCubit() : super(HomeState());

  Future<List<BodyReco>> getRecolectores() async {
    final id = await SharedPreferencesManager("idUSer").load();
    final t = await await mis.obtenerRecolectores(int.parse(id!));
    return t.body!;
  }
}
