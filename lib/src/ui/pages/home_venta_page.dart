import 'package:acopios/src/data/model/mayorista_model.dart';
import 'package:acopios/src/ui/blocs/home_mayorista/home_mayorista_cubit.dart';
import 'package:acopios/src/ui/pages/agregar_mayorista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../widgets/speed_dial_widget.dart';

class HomeVentaPage extends StatefulWidget {
  const HomeVentaPage({super.key});

  @override
  State<HomeVentaPage> createState() => _HomeVentaPageState();
}

class _HomeVentaPageState extends State<HomeVentaPage> {
  late HomeMayoristaCubit _cubit;

  late Future<List<MayoristaModel>> _future;

  @override
  void initState() {
    super.initState();
    _cubit = HomeMayoristaCubit();

    _init();
  }

  _init() {
    _future = _cubit.obtenerMayoristas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(elevation: 8, title: const Text("Mayoristas")),
      body: FutureBuilder<List<MayoristaModel>>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: const CircularProgressIndicator.adaptive(),
              );
            }
            final list = snapshot.data ?? [];

            if (list.isEmpty) {
              return Center(
                child: Text("Sin mayoritas"),
              );
            }
            return _listMayoristas(list);
          }),
      floatingActionButton: _option(),
    ));
  }

  Widget _listMayoristas(List<MayoristaModel> l) => ListView(
        children: List.generate(
            l.length,
            (index) => Card(
                  child: ListTile(
                    title: Text(l[index].nombre!),
                    trailing:
                        TextButton(child: Text("Comprar"), onPressed: () {}),
                  ),
                )),
      );

  Widget _option() => SpeedDial(children: [
        speedDialWidget(
          Icons.factory_outlined,
          'Añadir mayorista',
          () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AgregarMayorista())).then((value) {
                  _init();
                  setState(() {
                    
                  });
                });
          },
        ),
      ], child: const Icon(Icons.add));
}
