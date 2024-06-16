import 'package:acopios/src/data/model/material_model.dart';
import 'package:acopios/src/data/model/mayorista_model.dart';
import 'package:acopios/src/ui/blocs/material/material_cubit.dart';
import 'package:acopios/src/ui/blocs/venta/venta_cubit.dart';
import 'package:acopios/src/ui/pages/resume_venta.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VentaPage extends StatefulWidget {
  final MayoristaModel mayoristaModel;

  const VentaPage({super.key, required this.mayoristaModel});

  @override
  State<VentaPage> createState() => _VentaPageState();
}

class _VentaPageState extends State<VentaPage> {
  late VentaCubit _cubit;
  late Future<List<MaterialModel>> _future;
  late Size _size;
  final Map<int, TextEditingController> _controllers = {};
  final Map<int, TextEditingController> _controllers2 = {};
  final Map<int, bool> _isEditing = {};
  @override
  void initState() {
    super.initState();
    _cubit = VentaCubit();
    _future = _cubit.obtenerMateriales();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => _cubit,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          title: const Text("Nueva venta"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<MaterialModel>>(
              future: _future,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                final l = snapshot.data ?? [];

                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  l[index].nombre!,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: _size.width * .32,
                                  child: InputWidget(
                                      controller: _controllers[index]!,
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
                                      }),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: _size.width * .32,
                                  child: InputWidget(
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
                                const SizedBox(height: 10),
                                if (_isEditing[index]!)
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _isEditing[index] = false;
                                        });
                                        final m = l[index];
                                        final mat = MaterialCustom(
                                            idMaterial: m.idMaterial!,
                                            valor: double.parse(
                                                _controllers2[index]!.text),
                                            codigo: m.codigo!,
                                            valorCompra: double.parse(
                                                _controllers2[index]!.text),
                                            cantidad: double.parse(
                                                _controllers[index]!.text),
                                            name: m.nombre!);

                                        _cubit.updateMaterial(mat);
                                      },
                                      child: const Text("Asignar")),
                              ],
                            ),
                          ),
                        );
                      })),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<VentaCubit, VentaState>(
                      builder: (context, state) {
                        return BtnWidget(
                            action: () async{
                                 final r =
                    await _cubit.registrarVenta(widget.mayoristaModel);
                if (r.isEmpty) return;
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ResumenVentaPage(
                            recolectorModel: widget.mayoristaModel,
                            data: r)));
                            },
                            txt: "Finalizar",
                            enabled: state.materiales != null &&
                                state.materiales!.isNotEmpty);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
        ),
      )),
    );
  }
}
