// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/ui/blocs/material/material_cubit.dart' as c;
import 'package:acopios/src/ui/helpers/dialog_helper.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/alert_dialog_helper.dart';

class MyPricePage extends StatefulWidget {
  const MyPricePage({super.key});

  @override
  State<MyPricePage> createState() => _MyPricePageState();
}

class _MyPricePageState extends State<MyPricePage> {
  late c.MaterialCubit _cubit;

  late Future<List<c.MaterialCustom>> _future;

  @override
  void initState() {
    super.initState();

    _cubit = c.MaterialCubit();
    _init(false);
  }

  _init(enabled) {
    _future = _cubit.obtenerMateriales(enabled);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(elevation: 8, title: const Text("Mis precios")),
        body: BlocBuilder<c.MaterialCubit, c.MaterialState>(
          builder: (context, state) {
            return Stack(
              children: [
                _body(),
                Visibility(visible: state.loading, child: const LoadingWidget())
              ],
            );
          },
        ),
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
          ],
        ),
      );

  Widget _search() => InputWidget(
      controller: TextEditingController(),
      hintText: "Buscar",
      icon: Icons.search,
      onChanged: (e) {});

  Widget _listCard() => Expanded(
      child: FutureBuilder<List<c.MaterialCustom>>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            final list = snapshot.data!;
            return ListView(
              children:
                  List.generate(list.length, (index) => _card(list[index])),
            );
          }));
  Widget _card(c.MaterialCustom m) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(
              Icons.recycling_outlined,
              color: Colors.green,
            ),
            title: Text(m.name),
            subtitle: Text("\$ ${currencyFormat.format(m.valor.toInt())}"),
            trailing: TextButton(
                onPressed: () {
                  _cubit.txtPrice.clear();
                  _dialog(m);
                },
                child: const Text("Dar precio")),
          ),
        ),
      );

  void _dialog(c.MaterialCustom m) => dialogButton(
      context: context,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter s) {
          return Column(
            children: [
              Text("Ingresa precio para el Material ${m.name}"),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputWidget(
                    controller: _cubit.txtPrice,
                    hintText: "0.0",
                    list: [FilteringTextInputFormatter.digitsOnly],
                    type: TextInputType.number,
                    icon: Icons.monetization_on,
                    onChanged: (e) {
                      s(() {});
                    }),
              ),
              const SizedBox(height: 10),
              BtnWidget(
                  action: () async {
                    Navigator.pop(context);
                    final r = await _cubit.asignarPrecio(m);

                    if (r) {
                      _init(
                          true); // Actualizar la lista de materiales después de asignar el precio

                      setState(() {});
                    } else {
                      alert(
                          context,
                          const Column(
                            children: [
                              Text("No fue posible asignar el precio")
                            ],
                          ),
                          action1: () {});
                    }

                    setState(() {});
                    _cubit.txtPrice.clear();
                  },
                  txt: "Agregar ",
                  enabled: _cubit.txtPrice.text.isNotEmpty),
              const SizedBox(height: 10),
            ],
          );
        },
      ));
}
