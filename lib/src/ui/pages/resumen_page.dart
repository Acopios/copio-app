// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:acopios/src/ui/blocs/compra/compra_cubit.dart';
import 'package:acopios/src/ui/pages/home_page.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class ResumenPage extends StatefulWidget {
  final bool isDetalle;
  final List<Map<String, dynamic>>? data;
  final RecolectorModel recolectorModel;
  const ResumenPage(
      {super.key,
      required this.isDetalle,
      this.data,
      required this.recolectorModel});

  @override
  State<ResumenPage> createState() => _ResumenPagState();
}

class _ResumenPagState extends State<ResumenPage> {
  late Size _size;
  double totalKilos = 0;
  double valorPagar = 0;
  double valor = 0;
  final _compraC = CompraCubit();

  Map<String, double> calcularTotales() {
    for (var item in widget.data!) {
      totalKilos += item["cantidad"];
      valorPagar += item["total"];
      if(!widget.isDetalle){
        valor += item["valor"] * item["cantidad"];
      }
    }

    return {"totalKilos": totalKilos, "valorPagar": valorPagar};
  }

  bool loading = false;
  @override
  void initState() {
    super.initState();
    calcularTotales();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text("Resumen"),
      ),
      body: Stack(
        children: [
          _body(),
          Visibility(visible: loading, child: const LoadingWidget())
        ],
      ),
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
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recolector: ${widget.recolectorModel.nombres}"),
                      Text("Kilos ingresados: $totalKilos"),
                      Text("Valor a pagar: $valorPagar"),
                      Visibility(
                        visible:!widget.isDetalle,
                        child: Text("Ganancia obtenida: ${valor - valorPagar}")),
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
                  widget.data!.length,
                  (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _row(
                              txt1: widget.data![index]["material"].toString(),
                              txt2: widget.data![index]["cantidad"].toString(),
                              txt3: widget.data![index]["precioUnidad"]
                                  .toString(),
                              txt4: widget.data![index]["total"].toString()),
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
                    action: () async {
                      setState(() {
                        loading = true;
                      });
                      final r = await _compraC.realizarCompra(widget.data!);
                      if (r) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const HomePage()),
                            (route) => false);
                      }
                      setState(() {
                        loading = false;
                      });
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
