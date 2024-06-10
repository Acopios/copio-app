import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:acopios/src/ui/blocs/home/home_cubit.dart';
import 'package:acopios/src/ui/pages/login_page.dart';
import 'package:acopios/src/ui/pages/movimientos_page.dart';
import 'package:acopios/src/ui/pages/my_price_page.dart';
import 'package:acopios/src/ui/pages/reclector_page.dart';
import 'package:acopios/src/ui/pages/report_page.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
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

  late Future<List<RecolectorModel>> _future;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    _future = _homeC.obtenerRecolectores();
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
      child: FutureBuilder<List<RecolectorModel>>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            final list = snapshot.data ?? [];

            if (list.isEmpty) {
              return Center(
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
              );
            }
            return ListView(
              children:
                  List.generate(list.length, (index) => _card(list[index])),
            );
          }));

  Widget _card(RecolectorModel r) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text("${r.nombres} ${r.apellidos}"),
            subtitle: Text(r.identificacion!),
            trailing: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ReportPage(
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
          'Movimientos',
          () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const MovimientosPage()));
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
                MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false);
          },
        ),
      ], child: const Icon(Icons.add));
}
