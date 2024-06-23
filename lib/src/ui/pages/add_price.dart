import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/material/material_cubit.dart' as m;

class AddPrice extends StatefulWidget {
  final int id;
  const AddPrice({super.key, required this.id});

  @override
  State<AddPrice> createState() => _AddPriceState();
}

class _AddPriceState extends State<AddPrice> {
  final _cubic = m.MaterialCubit();
  final Map<int, TextEditingController> _controllers = {};
  final Map<int, bool> _isEditing = {};

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    _cubic.obtenerMateriales(false);
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubic,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(elevation: 8, title: const Text("Añadir precio")),
        body: BlocBuilder<m.MaterialCubit, m.MaterialState>(
          builder: (context, state) {
            final list = state.list ?? [];
            return Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                children: [
                  Column(
                    children: [
                      _search(),
                      _clearFilter(),
                      const SizedBox(height: 10),
                      Expanded(
                          child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          // Crear un controlador para cada entrada si no existe
                          if (!_controllers.containsKey(index)) {
                            _controllers[index] = TextEditingController();
                            _isEditing[index] =
                                false; // Inicialmente no está editando
                          }
                          return ListTile(
                            title: Text(list[index].nombre!),
                            trailing: SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: InputWidget(
                                      controller: _controllers[index]!,
                                      hintText: "2.00",
                                      icon: Icons.monetization_on,
                                      onChanged: (value) {
                                        setState(() {
                                          _isEditing[index] = value.isNotEmpty;
                                        });
                                      },
                                    ),
                                  ),
                                  if (_isEditing[index]!)
                                    SizedBox(
                                      width: 50,
                                      child: IconButton(
                                        onPressed: () {
                                          _cubic.asignarPrecio(
                                              list[index],
                                              widget.id,
                                              _controllers[index]!.text);

                                          setState(() {
                                            _isEditing[index] = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ))
                    ],
                  ),
                  Visibility(
                    visible: state.loading,
                    child: const LoadingWidget(),
                  )
                ],
              ),
            );
          },
        ),
      )),
    );
  }

  Widget _search() => InputWidget(
      controller: _cubic.txtSearch,
      hintText: "Buscar",
      icon: Icons.search,
      onChanged: (e) {
        _cubic.search(e);
      });

  Widget _clearFilter() => BlocBuilder<m.MaterialCubit, m.MaterialState>(
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
                    _cubic.deleteFilter();
                  },
                )
              ],
            ),
          );
        },
      );
}
