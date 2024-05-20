import 'package:acopios/src/ui/pages/home/historial/alimenta_list_model.dart';
import 'package:acopios/src/ui/pages/home/historial/historial_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'historial_state.dart';

class HistorialCubit extends Cubit<HistorialState> {

  final hs = HistorialService();
  HistorialCubit() : super(HistorialState());

  Future<List<BodyAlimentaList>> getListado(int id)async{
    final r = await hs.obtenerListado(id: id);
return  r.body!;
  }
}
