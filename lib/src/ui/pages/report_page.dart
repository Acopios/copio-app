// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:acopios/src/ui/blocs/compra/compra_cubit.dart';
import 'package:acopios/src/ui/blocs/material/material_cubit.dart';
import 'package:acopios/src/ui/helpers/dialog_helper.dart';
import 'package:acopios/src/ui/pages/resumen_page.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/input_widget.dart';

class ReportPage extends StatefulWidget {
  final RecolectorModel recolectorModel;
  const ReportPage({super.key, required this.recolectorModel});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late CompraCubit _compraC;

  @override
  void initState() {
    super.initState();
    _compraC = CompraCubit();
    _init();
  }

  _init() {
    _compraC.obtenerMateriales();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _compraC,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          title: const Text("Nuevo reporte"),
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

  Widget _listCard() => BlocBuilder<CompraCubit, CompraState>(
        builder: (context, state) {
          final list = state.materiales ?? [];
          return Expanded(
              child: ListView(
            children: List.generate(list.length, (index) => _card(list[index])),
          ));
        },
      );
  Widget _card(MaterialCustom m) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(
              Icons.recycling_outlined,
              color: Colors.green,
            ),
            title: Text(m.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\$ ${m.valorCompra}"),
                Text("Cantidad: ${m.cantidad} KG"),
              ],
            ),
            trailing: TextButton(
                onPressed: () {
                  _dialog(m);
                },
                child: const Text("Dar precio")),
          ),
        ),
      );

  Widget _btn() => BtnWidget(
      action: () async {
        final r = await _compraC.registrarCompra(widget.recolectorModel);
        if (r.isEmpty) return;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ResumenPage(
                      isDetalle: false,
                      recolectorModel: widget.recolectorModel,
                      data: r,
                    )));
      },
      txt: "Finalizar",
      enabled: true);

  void _dialog(MaterialCustom m) => dialogButton(
      context: context,
      child: StatefulBuilder(builder: (BuildContext context, StateSetter s) {
        return Column(
          children: [
            Text("Ingresa precio de venta para el Material ${m.name}"),
            Text("Precio del material ${m.valor}"),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputWidget(
                  controller: _compraC.txt,
                  hintText: "0.0",
                  icon: Icons.monetization_on,
                  onChanged: (e) {
                    s(() {});
                  }),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputWidget(
                  controller: _compraC.txtC,
                  hintText: "2kg",
                  icon: Icons.line_weight_rounded,
                  onChanged: (e) {
                    s(() {});
                  }),
            ),
            const SizedBox(height: 10),
            BtnWidget(
                action: () {
                  _compraC.updateMaterial(m);
                  Navigator.pop(context);
                  _compraC.txt.clear();
                  _compraC.txtC.clear();
                },
                txt: "Agregar ",
                enabled: _compraC.txt.text.isNotEmpty &&
                    _compraC.txtC.text.isNotEmpty),
            const SizedBox(height: 10),
          ],
        );
      }));
}
