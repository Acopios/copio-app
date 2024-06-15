// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/data/model/precio_material.dart';
import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:acopios/src/ui/blocs/compra/compra_cubit.dart';
import 'package:acopios/src/ui/blocs/material/material_cubit.dart';
import 'package:acopios/src/ui/pages/resumen_page.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/input_widget.dart';

class CompraPage extends StatefulWidget {
  final RecolectorModel recolectorModel;
  const CompraPage({super.key, required this.recolectorModel});

  @override
  State<CompraPage> createState() => _CompraPageState();
}

class _CompraPageState extends State<CompraPage> {
  late CompraCubit _compraC;

  late Future<List<PrecioModel>> _future;
  final Map<int, TextEditingController> _controllers = {};
  final Map<int, bool> _isEditing = {};
  @override
  void initState() {
    super.initState();
    _compraC = CompraCubit();
    _init();
  }

  _init() {
    _future = _compraC.precioAsignacion(widget.recolectorModel.idListaPrecios!);
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
      create: (context) => _compraC,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          title: const Text("Nueva Compra"),
        ),
        body: _body(),
      )),
    );
  }

  Widget _body() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _search(),
            const SizedBox(height: 10),
            _listCard(),
            const SizedBox(height: 10),
            _btn(),
          ],
        ),
      );

  Widget _search() => InputWidget(
      controller: TextEditingController(),
      hintText: "Buscar",
      icon: Icons.search,
      onChanged: (e) {});

  Widget _listCard() => FutureBuilder(
      future: _future,
      builder: (_, s) {
        if (!s.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        final list = s.data ?? [];

        if (list.isEmpty) {
          return const Center(child: Text("Sin información"));
        }

        return Expanded(
            child: ListView(
                children: List.generate(list.length, (index) {
          if (!_controllers.containsKey(index)) {
            _controllers[index] = TextEditingController();
            _isEditing[index] = false;
          }

          return ListTile(
            title: Text(list[index].idMaterial.nombre),
            subtitle:
                Text("\$ ${currencyFormat.format(list[index].valor.toInt())}"),
            trailing: SizedBox(
              width: 200,
              child: Row(
                children: [
                  SizedBox(
                      width: 150,
                      child: InputWidget(
                          controller: _controllers[index]!,
                          hintText: "2kg",
                          icon: (Icons.line_weight),
                          onChanged: (e) {
                            setState(() {
                              _isEditing[index] = e.isNotEmpty;
                            });
                          })),
                  if (_isEditing[index]!)
                    SizedBox(
                      width: 50,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _isEditing[index] = false;
                          });
                          final m = list[index].idMaterial;
                          final valor = list[index].valor;
                          final mat = MaterialCustom(
                              idMaterial: m.idMaterial,
                              valor: valor,
                              codigo: m.codigo,
                              valorCompra: valor,
                              cantidad: double.parse(_controllers[index]!.text),
                              name: m.nombre);

                          _compraC.updateMaterial(mat);
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
        })));
      });

  Widget _btn() => BlocBuilder<CompraCubit, CompraState>(
        builder: (context, state) {
          return BtnWidget(
              action: () async {
                final r =
                    await _compraC.registrarCompra(widget.recolectorModel);
                if (r.isEmpty) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ResumenPage(
                            isDetalle: false,
                            recolectorModel: widget.recolectorModel,
                            data: r)));
              },
              txt: "Finalizar",
              enabled: state.materiales!=null && state.materiales!.isNotEmpty);
        },
      );
}
