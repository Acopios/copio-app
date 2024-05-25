import 'package:acopios/src/data/model/material_model.dart';
import 'package:acopios/src/ui/blocs/material/material_cubit.dart';
import 'package:acopios/src/ui/helpers/dialog_helper.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPricePage extends StatefulWidget {
  const MyPricePage({super.key});

  @override
  State<MyPricePage> createState() => _MyPricePageState();
}

class _MyPricePageState extends State<MyPricePage> {
  late MaterialCubit _cubit;

  late Future<List<MaterialCustom>> _future;

  @override
  void initState() {
    super.initState();

    _cubit = MaterialCubit();
    _init();
  }

  _init() {
    _future = _cubit.obtenerMateriales();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(elevation: 8, title: const Text("Mis precios")),
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
          ],
        ),
      );

  Widget _search() => InputWidget(
      controller: TextEditingController(),
      hintText: "Buscar",
      icon: Icons.search,
      onChanged: (e) {});

  Widget _listCard() => Expanded(
      child: FutureBuilder<List<MaterialCustom>>(
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
  Widget _card(MaterialCustom m) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(
              Icons.recycling_outlined,
              color: Colors.green,
            ),
            title: Text(m.name),
            subtitle: Text("\$ ${m.valor}"),
            trailing: TextButton(
                onPressed: () {
                  _dialog();
                },
                child: const Text("Dar precio")),
          ),
        ),
      );

  void _dialog() => dialogButton(
      context: context,
      child: Column(
        children: [
          const Text("Ingresa precio para el Material ****"),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputWidget(
                controller: TextEditingController(),
                hintText: "0.0",
                icon: Icons.monetization_on,
                onChanged: (e) {}),
          ),
          const SizedBox(height: 10),
          BtnWidget(action: () {}, txt: "Agregar ", enabled: false),
          const SizedBox(height: 10),
        ],
      ));
}
