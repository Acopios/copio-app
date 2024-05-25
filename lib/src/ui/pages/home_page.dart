import 'package:acopios/src/ui/pages/movimientos_page.dart';
import 'package:acopios/src/ui/pages/my_price_page.dart';
import 'package:acopios/src/ui/pages/reclector_page.dart';
import 'package:acopios/src/ui/pages/report_page.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/speed_dial_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      body: _body(),
      floatingActionButton: _option(),
    ));
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
          child: ListView(
        children: List.generate(8, (index) => _card()),
      ));

  Widget _card() => Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text("Juanito alimaña "),
            subtitle: const Text("Peres Murillo"),
            trailing: TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const ReportPage()));
            }, child: const Text("A reportar")),
          ),
        ),
      );

  Widget _option() => SpeedDial(children: [
        speedDialWidget(
          Icons.person_add,
          'Añadir recolector',
          () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>RecolectorPagState()));
          },
        ),
        speedDialWidget(
          Icons.monetization_on,
          'Mis precios',
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
          () {},
        ),
      ], child: Icon(Icons.add));
}
