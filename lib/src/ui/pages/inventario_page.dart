// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/ui/blocs/inventario/inventario_cubit.dart';
import 'package:acopios/src/ui/pages/add_material.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/input_widget.dart';

class InventarioPage extends StatefulWidget {
  const InventarioPage({super.key});

  @override
  State<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  late Size _size;

  final _movC = InventarioCubit();

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    _movC.listarInventar();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => _movC,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(elevation: 8, title: const Text("Inventario")),
        body: BlocBuilder<InventarioCubit, InventarioState>(
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _search(),
                      _clearFilter(),
                      const SizedBox(height: 10),
                      BlocBuilder<InventarioCubit, InventarioState>(
                        builder: (context, state) {
                          final list = state.list ?? [];
                          if (list.isEmpty) {
                            return Expanded(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Sin registros aun"),
                                    const SizedBox(height: 20),
                                    BtnWidget(
                                        action: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddMaterial()));
                                        },
                                        txt: "Crear inventario",
                                        enabled: true)
                                  ],
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: ListView(
                              children: List.generate(
                                list.length,
                                (index) => SizedBox(
                                  width: _size.width,
                                  child: ListTile(
                                    title: Text(list[index].material!.nombre!),
                                    subtitle: Text(
                                        "Dispinibilidad: ${list[index].cantidad} Kg"),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: state.loading,
                  child: const LoadingWidget(),
                )
              ],
            );
          },
        ),
      )),
    );
  }

  Widget _search() => InputWidget(
      controller: _movC.txtSearch,
      hintText: "Buscar",
      icon: Icons.search,
      onChanged: (e) {
        _movC.search(e);
      });

  Widget _clearFilter() => BlocBuilder<InventarioCubit, InventarioState>(
        builder: (context, state) {
          return Visibility(
            visible: state.isFilter,
            child: Row(
              children: [
                const Icon(Icons.clear_outlined),
                const SizedBox(width: 10),
                TextButton(
                  child: const Text("Limpiar Filtro"),
                  onPressed: () {
                    _movC.deleteFilter();
                  },
                )
              ],
            ),
          );
        },
      );
}
