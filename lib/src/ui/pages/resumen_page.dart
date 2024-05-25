import 'package:acopios/src/ui/pages/home_page.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:flutter/material.dart';

class ResumenPage extends StatefulWidget {
  final bool isDetalle;
  const ResumenPage({super.key, required this.isDetalle});

  @override
  State<ResumenPage> createState() => _ResumenPagState();
}

class _ResumenPagState extends State<ResumenPage> {
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text("Resumen"),
      ),
      body: _body(),
    ));
  }

  Widget _body() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: _size.width,
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recolector: Juan Perez"),
                      Text("Kilos ingresados: 12KG"),
                      Text("Valor a pagar: 12.000"),
                      Text("Ganancia obtenida: 12.000"),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            _row(
                txt1: "Material", txt2: "KG", txt3: "Precio KG", txt4: "Total"),
            const Divider(),
            Expanded(
                child: ListView(
              children: List.generate(
                  10,
                  (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _row(
                              txt1: "Material $index",
                              txt2: "2",
                              txt3: "300",
                              txt4: "600"),
                          const Divider()
                        ],
                      )),
            )),
            const SizedBox(
              height: 10,
            ),
            widget.isDetalle
                ? const SizedBox()
                : BtnWidget(
                    action: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false);
                    },
                    txt: "Finalizar",
                    enabled: true),
            const SizedBox(
              height: 10,
            ),
            widget.isDetalle
                ? const SizedBox()
                : TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Editar"))
          ],
        ),
      );

  Widget _row({
    required String txt1,
    required String txt2,
    required String txt3,
    required String txt4,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(txt1),
            ),
            Expanded(
              child: Center(child: Text(txt2)),
            ),
            Expanded(child: Center(child: Text(txt3))),
            Expanded(
                child:
                    Container(alignment: Alignment.center, child: Text(txt4))),
          ],
        ),
      );
}
