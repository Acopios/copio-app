// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/ui/blocs/material/material_cubit.dart' as c;
import 'package:acopios/src/ui/pages/add_price.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/precio_material.dart';

class MyPricePage extends StatefulWidget {
  const MyPricePage({super.key});

  @override
  State<MyPricePage> createState() => _MyPricePageState();
}

class _MyPricePageState extends State<MyPricePage> {
  late c.MaterialCubit _cubit;

  late Future<List<PrecioMaterial>> _future;
  int tamanio = 0;

  @override
  void initState() {
    super.initState();

    _cubit = c.MaterialCubit();
    _init(false);
  }

  _init(enabled) {
    _future = _cubit.precioMateriales();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(elevation: 8, title: const Text("Lista de precios")),
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
          children: [const SizedBox(height: 30), _btn(), _precios()],
        ),
      );

  Widget _precios() => Expanded(
        child: FutureBuilder<List<PrecioMaterial>>(
          future: _future,
          builder: (_, s) {
            if (!s.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            final list = s.data ?? [];
            tamanio = list.length;
            if (list.isEmpty) {
              return const Center(
                child: Text("Sin información"),
              );
            }
            return ListView(
              children: List.generate(
                  list.length,
                  (index) => ExpansionTile(
                    leading: const Icon(Icons.monetization_on),
                        title: Text('Lista de precios  ${list[index].idAsignacion}'),
                        children: List.generate(list[index].precios.length, (index2) => ListTile(

                          title: Text(list[index].precios[index2].idMaterial.nombre),
                          subtitle: Text(currencyFormat.format(list[index].precios[index2].valor.toInt())),
                        )),
                      )),
            );
          },
        ),
      );

  Widget _btn() => Center(
      child: BtnWidget(
          action: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddPrice(
                          id: tamanio,
                        ))).then((value) {
              _init(false);
            });
          },
          txt: "Crear Lista",
          enabled: true));
}
