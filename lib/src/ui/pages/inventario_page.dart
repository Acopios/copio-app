// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/data/model/inventario_model.dart';
import 'package:acopios/src/ui/blocs/inventario/inventario_cubit.dart';
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

  late Future<List<InventarioModel>> _future;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    _future = _movC.listarInventar();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => _movC,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(elevation: 8, title: const Text("Inventario")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _search(),
              const SizedBox(height: 10),
              Expanded(
                  child: FutureBuilder<List<InventarioModel>>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        final list = snapshot.data ?? [];

                        if (list.isEmpty) {
                          return const Center(
                            child: Text("Sin registros aun"),
                          );
                        }
                        return ListView(
                          children: List.generate(
                            list.length,
                            (index) => SizedBox(
                              width: _size.width,
                              child: ListTile(
                                title: Text(list[index].material!.nombre!),
                                subtitle: Text("Dispinibilidad: ${list[index].cantidad} Kg"),
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
