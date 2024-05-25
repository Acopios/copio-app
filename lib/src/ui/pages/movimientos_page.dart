import 'package:flutter/material.dart';

import '../widgets/input_widget.dart';
import 'resumen_page.dart';

class MovimientosPage extends StatefulWidget {
  const MovimientosPage({super.key});

  @override
  State<MovimientosPage> createState() => _MovimientosPageState();
}

class _MovimientosPageState extends State<MovimientosPage> {
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(elevation: 8, title: const Text("Movimientos")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _search(),
            const SizedBox(height: 10),
            Expanded(
                child: ListView(
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: _size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Recolector: Juan Perez"),
                          const Text("Kilos ingresados: 12KG"),
                          const Text("Valor a pagar: 12.000"),
                          const Text("Ganancia obtenida: 12.000"),
                          Center(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const ResumenPage(
                                                  isDetalle: true,
                                                )));
                                  },
                                  child: const Text("Ver Detalle")))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    ));
  }

  Widget _search() => InputWidget(
      controller: TextEditingController(),
      hintText: "Buscar",
      icon: Icons.search,
      onChanged: (e) {});
}
