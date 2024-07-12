// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:acopios/src/ui/blocs/home/home_cubit.dart';
import 'package:acopios/src/ui/helpers/alert_dialog_helper.dart';
import 'package:acopios/src/ui/helpers/dialog_helper.dart';
import 'package:acopios/src/ui/pages/home_venta_page.dart';
import 'package:acopios/src/ui/pages/login_page.dart';
import 'package:acopios/src/ui/pages/inventario_page.dart';
import 'package:acopios/src/ui/pages/my_price_page.dart';
import 'package:acopios/src/ui/pages/reclector_page.dart';
import 'package:acopios/src/ui/pages/compra_page.dart';
import 'package:acopios/src/ui/pages/report_page.dart';
import 'package:acopios/src/ui/pages/reuso_page.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:acopios/src/ui/widgets/speed_dial_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeC = HomeCubit();

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    _homeC.obtenerRecolectores();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeC,
      child: SafeArea(
          child: Scaffold(
        body: _body(),
        floatingActionButton: _option(),
      )),
    );
  }

  Widget _body() => BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    _search(),
                    _clearFilter(),
                    const SizedBox(height: 10),
                    _listCard(),
                  ],
                ),
              ),
              Visibility(visible: state.loading, child: const LoadingWidget())
            ],
          );
        },
      );

  Widget _search() => InputWidget(
      controller: _homeC.searchTxt,
      hintText: "Buscar",
      icon: Icons.search,
      onChanged: (e) {
        _homeC.search(e);
      });
  Widget _clearFilter() => BlocBuilder<HomeCubit, HomeState>(
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
                    _homeC.deleteFilter();
                  },
                )
              ],
            ),
          );
        },
      );

  Widget _listCard() => BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final list = state.listRecolectores ?? [];
          if (list.isEmpty) {
            return Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_outline_outlined, size: 80),
                    const Text("No cuentas con recolectores aun"),
                    BtnWidget(
                        action: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RecolectorPagState()));
                        },
                        txt: "Registrar",
                        enabled: true),
                  ],
                ),
              ),
            );
          }
          return Expanded(
            child: ListView(
              children:
                  List.generate(list.length, (index) => _card(list[index])),
            ),
          );
        },
      );

  Widget _card(RecolectorModel r) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: IconButton(
                onPressed: () {
                  dialogButton(
                      context: context,
                      child: Column(
                        children: [
                          ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RecolectorPagState(
                                            recolectorModel: r, isEdit: true)));
                              },
                              leading: const Icon(Icons.edit),
                              title: const Text("Editar")),
                          ListTile(
                              onTap: () async {
                                Navigator.pop(context);
                                final rr =
                                    await _homeC.eliminarUser(r.idRecolector!);
                                if (rr) {
                                  info(context, messageError,
                                      () => Navigator.pop(context));
                                  _init();
                                }
                              },
                              leading: const Icon(Icons.delete),
                              title: const Text("Eliminar Recolector")),
                          const SizedBox(height: 30),
                        ],
                      ),
                      isScrollControlled: false);
                },
                icon: const Icon(Icons.account_circle_outlined)),
            title: Text("${r.nombres} ${r.apellidos}"),
            subtitle: Text(r.identificacion!),
            trailing: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CompraPage(
                                recolectorModel: r,
                              )));
                },
                child: const Text("Comprar")),
          ),
        ),
      );

  Widget _option() => SpeedDial(children: [
        speedDialWidget(
          Icons.person_add,
          'Añadir recolector',
          () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const RecolectorPagState()));
          },
        ),
        speedDialWidget(
          Icons.monetization_on,
          'Lista de precios',
          () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const MyPricePage()));
          },
        ),
        speedDialWidget(
          Icons.history_edu_outlined,
          'Inventario',
          () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const InventarioPage()));
          },
        ),
        speedDialWidget(
          Icons.history_edu_outlined,
          'Reportes',
          () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ReportPage()));
          },
        ),
        speedDialWidget(
          Icons.production_quantity_limits,
          'Ventas',
          () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const HomeVentaPage()));
          },
        ),
        speedDialWidget(
          Icons.update,
          'Reuso',
          () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ReusoPage()));
          },
        ),
        speedDialWidget(
          Icons.exit_to_app,
          'Cerrar sesión',
          () async {
            await SharedPreferencesManager("token").remove();
            await SharedPreferencesManager("id").remove();

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false);
          },
        ),
      ], child: const Icon(Icons.add));
}
