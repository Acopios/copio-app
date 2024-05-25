import 'package:acopios/src/ui/helpers/dialog_helper.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class MyPricePage extends StatefulWidget {
  const MyPricePage({super.key});

  @override
  State<MyPricePage> createState() => _MyPricePageState();
}

class _MyPricePageState extends State<MyPricePage> {
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(elevation: 8, title: Text("Mis precios")),
      body: _body(),
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
            leading: const Icon(
              Icons.recycling_outlined,
              color: Colors.green,
            ),
            title: const Text("Material "),
            subtitle: Text("\$0.0"),
            trailing: TextButton(
                onPressed: () {
                  _dialog();
                },
                child: Text("Dar precio")),
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
