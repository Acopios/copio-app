import 'package:acopios/src/ui/blocs/material/material_cubit.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:flutter/material.dart';

import '../../data/model/material_model.dart';

class AddPrice extends StatefulWidget {
  final int id;
  const AddPrice({super.key, required this.id});

  @override
  State<AddPrice> createState() => _AddPriceState();
}

class _AddPriceState extends State<AddPrice> {
  final _cubic = MaterialCubit();
  late Future<List<MaterialModel>> _future;
  final Map<int, TextEditingController> _controllers = {};
  final Map<int, bool> _isEditing = {};

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    _future = _cubic.obtenerMateriales(false);
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(elevation: 8, title: const Text("Añadir precio")),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: FutureBuilder<List<MaterialModel>>(
            future: _future,
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              final list = snapshot.data ?? [];
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  // Crear un controlador para cada entrada si no existe
                  if (!_controllers.containsKey(index)) {
                    _controllers[index] = TextEditingController();
                    _isEditing[index] = false; // Inicialmente no está editando
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
                                  _cubic.asignarPrecio(list[index], widget.id,
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
              );
            }),
      ),
    ));
  }
}
