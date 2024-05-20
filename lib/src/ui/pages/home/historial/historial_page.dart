import 'package:acopios/src/ui/pages/home/historial/alimenta_list_model.dart';
import 'package:acopios/src/ui/pages/home/historial/cubit/historial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoriaPage extends StatefulWidget {
  final int id;
  const HistoriaPage({super.key, required this.id});

  @override
  State<HistoriaPage> createState() => _HistoriaPageState();
}

class _HistoriaPageState extends State<HistoriaPage> {
  late HistorialCubit _cubit;
  late Future<List<BodyAlimentaList>> _future;

  @override
  void initState() {
    super.initState();

    _cubit = HistorialCubit();
    inti();
  }

  inti() {
    _future = _cubit.getListado(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Reportes ${widget.id}"),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder<List<BodyAlimentaList>>(
                future: _future,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  final l = snapshot.data;
                  return Expanded(
                    child: ListView(
                      children: List.generate(
                          l!.length,
                          (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(l[index].fecha!.toIso8601String()),
                                  SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              .4,
                                      child: ListView(
                                        children: List.generate(
                                            l[index].alimentos!.length,
                                            (j) => Card(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                            "Material: ${l[index].alimentos![j].idMaterial!.nombre}"),
                                                        Text(
                                                            "Código: ${l[index].alimentos![j].idMaterial!.codigo}"),
                                                        Text(
                                                            "Valor: ${l[index].alimentos![j].valor}"),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                      ))
                                ],
                              )),
                    ),
                  );
                })
          ],
        ),
      );
}
