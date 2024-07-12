// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/data/model/mayorista_model.dart';
import 'package:acopios/src/ui/blocs/home_mayorista/home_mayorista_cubit.dart';
import 'package:acopios/src/ui/pages/agregar_mayorista.dart';
import 'package:acopios/src/ui/pages/venta_page.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../helpers/alert_dialog_helper.dart';
import '../helpers/dialog_helper.dart';
import '../widgets/input_widget.dart';
import '../widgets/speed_dial_widget.dart';

class HomeVentaPage extends StatefulWidget {
  const HomeVentaPage({super.key});

  @override
  State<HomeVentaPage> createState() => _HomeVentaPageState();
}

class _HomeVentaPageState extends State<HomeVentaPage> {
  late HomeMayoristaCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = HomeMayoristaCubit();

    _init();
  }

  _init() {
    _cubit.obtenerMayoristas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(elevation: 8, title: const Text("Mayoristas")),
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocBuilder<HomeMayoristaCubit, HomeMayoristaState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      _search(),
                      _clearFilter(),
                      const SizedBox(height: 10),
                      BlocBuilder<HomeMayoristaCubit, HomeMayoristaState>(
                        builder: (context, state) {
                          final list = state.list ?? [];
                          if (list.isEmpty) {
                            return const Expanded(
                              child: Center(
                                child: Text("Sin mayoritas"),
                              ),
                            );
                          }
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _listMayoristas(list),
                            ),
                          );
                        },
                      ),
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
      ),
      floatingActionButton: _option(),
    ));
  }

  Widget _listMayoristas(List<MayoristaModel> l) => ListView(
        children: List.generate(
            l.length,
            (index) => Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          dialogButton(
                              context: context,
                              child: Column(
                                children: [
                                  ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    AgregarMayorista(
                                                      isEdit: true,
                                                      mayoristaModel: l[index],
                                                    ))).then((value) {
                                          _init();
                                          setState(() {});
                                        });
                                      },
                                      leading: const Icon(Icons.edit),
                                      title: const Text("Editar")),
                                  ListTile(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final rr =
                                            await _cubit.eliminarMayorista(
                                                l[index].idMayorista!);
                                        if (rr) {
                                          info(context, messageError,
                                              () => Navigator.pop(context));
                                          _init();
                                        }
                                      },
                                      leading: const Icon(Icons.delete),
                                      title: const Text("Eliminar Mayorista")),
                                  const SizedBox(height: 30),
                                ],
                              ),
                              isScrollControlled: false);
                        },
                        child: CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.factory,
                                size: MediaQuery.sizeOf(context).height * .07)),
                      ),
                      const SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          _text("Bodega:", l[index].nombre!),
                          _text("Dirección:", l[index].direccion!),
                          _text("Representante:", l[index].direccion!),
                          _text("Nit:", l[index].nit!),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(left: 50),
                            child: TextButton(
                                child: const Text("Vender"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => VentaPage(
                                              mayoristaModel: l[index])));
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                ))),
      );

  Widget _text(String text1, String txt2) => RichText(
        text: TextSpan(children: [
          TextSpan(
              text: text1,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          TextSpan(
              text: " $txt2",
              style: const TextStyle(
                  color: Colors.black, overflow: TextOverflow.ellipsis)),
        ]),
      );
  Widget _option() => SpeedDial(children: [
        speedDialWidget(
          Icons.factory_outlined,
          'Añadir mayorista',
          () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AgregarMayorista()))
                .then((value) {
              _init();
              setState(() {});
            });
          },
        ),
      ], child: const Icon(Icons.add));

  Widget _search() => InputWidget(
      controller: _cubit.txtSearch,
      hintText: "Buscar",
      icon: Icons.search,
      onChanged: (e) {
        _cubit.search(e);
      });

  Widget _clearFilter() => BlocBuilder<HomeMayoristaCubit, HomeMayoristaState>(
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
