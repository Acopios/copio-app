import 'package:acopios/src/ui/blocs/reuso/reuso_cubit.dart';
import 'package:acopios/src/ui/pages/resumen_reuso_page.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/material/material_cubit.dart';
import '../widgets/input_widget.dart';

class ReusoPage extends StatefulWidget {
  ReusoPage({super.key});

  @override
  State<ReusoPage> createState() => _ReusoPageState();
}

class _ReusoPageState extends State<ReusoPage> {
  late Size _size;
  late ReusoCubit _cubit;
  final Map<int, TextEditingController> _controllers = {};
  final Map<int, TextEditingController> _controllers2 = {};
  final Map<int, bool> _isEditing = {};
  @override
  void initState() {
    super.initState();
    _cubit = ReusoCubit();
    _cubit.obtenerMateriales();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => _cubit,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(title: Text("Reuso"), elevation: 8),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: _body(),
        ),
      )),
    );
  }

  Widget _body() => Stack(
        children: [
          Column(
            children: [
              _search(),
              _clearFilter(),
              const SizedBox(height: 10),
              BlocBuilder<ReusoCubit, ReusoState>(
                builder: (context, state) {
                  final l = state.list ?? [];
                  return Expanded(
                    child: ListView(
                        children: List.generate(l.length, (index) {
                      if (!_controllers.containsKey(index)) {
                        _controllers[index] = TextEditingController();
                        _controllers2[index] = TextEditingController();
                        _isEditing[index] = false;
                      }
                      return Card(
                          child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(l[index].nombre!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    FutureBuilder<double>(
                                        future: _cubit
                                            .cantidad(l[index].idMaterial!),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const SizedBox();
                                          }

                                          return Text(
                                              "Disponible en bodega: ${snapshot.data} ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold));
                                        }),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: _size.width * .4,
                                            child: InputWidget(
                                                controller:
                                                    _controllers[index]!,
                                                type: TextInputType.number,
                                                list: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                hintText: "Cantidad",
                                                icon: Icons.line_weight,
                                                onChanged: (e) {
                                                  if (_controllers[index]!
                                                          .text
                                                          .isNotEmpty &&
                                                      _controllers2[index]!
                                                          .text
                                                          .isNotEmpty) {
                                                    _isEditing[index] = true;
                                                  } else {
                                                    _isEditing[index] = false;
                                                  }
                                                  setState(() {});
                                                })),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: _size.width * .4,
                                          child: InputWidget(
                                              list: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              type: TextInputType.number,
                                              controller: _controllers2[index]!,
                                              hintText: "Precio",
                                              icon: Icons.monetization_on,
                                              onChanged: (e) {
                                                if (_controllers[index]!
                                                        .text
                                                        .isNotEmpty &&
                                                    _controllers2[index]!
                                                        .text
                                                        .isNotEmpty) {
                                                  _isEditing[index] = true;
                                                } else {
                                                  _isEditing[index] = false;
                                                }
                                                setState(() {});
                                              }),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    if (_isEditing[index]!)
                                      Center(
                                        child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _isEditing[index] = false;
                                              });
                                              final m = l[index];
                                              final mat = MaterialCustom(
                                                  idMaterial: m.idMaterial!,
                                                  valor: double.parse(
                                                      _controllers2[index]!
                                                          .text),
                                                  codigo: m.codigo!,
                                                  valorCompra: double.parse(
                                                      _controllers2[index]!
                                                          .text),
                                                  cantidad: double.parse(
                                                      _controllers[index]!
                                                          .text),
                                                  name: m.nombre!);

                                              _cubit.updateMaterial(mat);
                                            },
                                            child: const Text("Asignar")),
                                      )
                                  ])));
                    })),
                  );
                },
              ),
              BlocBuilder<ReusoCubit, ReusoState>(
                builder: (context, state) {
                  return BtnWidget(
                      action: () async {
                             final r = await _cubit
                                    .registrarVenta();
                                if (r.isEmpty) return;
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ResumenReuoPage(
                                          
                                            data: r)));
                      },
                      txt: "Finalizar",
                      enabled: state.materiales != null &&
                          state.materiales!.isNotEmpty);
                },
              ),
            ],
          ),
        ],
      );

  Widget _search() => InputWidget(
      controller: _cubit.txtSearch,
      hintText: "Buscar",
      icon: Icons.search,
      onChanged: (e) {
        _cubit.search(e);
      });

  Widget _clearFilter() => BlocBuilder<ReusoCubit, ReusoState>(
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
                    _cubit.deleteFilter();
                  },
                )
              ],
            ),
          );
        },
      );
}
