// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/data/model/movimientos_model.dart';
import 'package:acopios/src/ui/blocs/movimientos/movimientos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/input_widget.dart';
import 'resumen_page.dart';

class MovimientosPage extends StatefulWidget {
  const MovimientosPage({super.key});

  @override
  State<MovimientosPage> createState() => _MovimientosPageState();
}

class _MovimientosPageState extends State<MovimientosPage> {
  late Size _size;

  final _movC = MovimientosCubit();

  late Future<List<MovimientosModel>> _future;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    _future = _movC.obtenerMovimientos();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => _movC,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(elevation: 8, title: const Text("Movimientos")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _search(),
              const SizedBox(height: 10),
              Expanded(
                  child: FutureBuilder<List<MovimientosModel>>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        final list = snapshot.data ?? [];
                        return ListView(
                          children: List.generate(
                            list.length,
                            (index) => SizedBox(
                              width: _size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Fecha compra: ${DateTime.parse(list[index].fecha!.toIso8601String())}"),
                                  Text(
                                      "recolector: ${list[index].recolector!.nombres}"),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child:FutureBuilder<List<double>>(
                                        future: _movC.caluculo(list[index].comprasPorRecolector!.compras!),
                                        builder: (context, snapshot) {
                                          if(!snapshot.hasData) return Container();
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                             
                                              Text("Kilos ingresados:  ${snapshot.data![0]}"),
                                              Text("Valor pagado: ${snapshot.data![1]}"),
                                              Center(
                                                  child: TextButton(
                                                      onPressed: () async{
                                                        final d = await _movC.toData(list[index].comprasPorRecolector!.compras!);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>  ResumenPage(
                                                                      isDetalle: true,
                                                                      data:  d,
                                                                      recolectorModel: list[index].recolector!,
                                                                      
                                                                    )));
                                                      },
                                                      child: const Text(
                                                          "Ver Detalle")))
                                            ],
                                          );
                                        }
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      )),
    );
  }

  Widget _search() => InputWidget(
      controller: TextEditingController(),
      hintText: "Buscar",
      icon: Icons.search,
      onChanged: (e) {});
}
