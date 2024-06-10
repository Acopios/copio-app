// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:acopios/src/ui/blocs/compra/compra_cubit.dart';
import 'package:acopios/src/ui/helpers/dialog_helper.dart';
import 'package:acopios/src/ui/pages/home_page.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  List<Map<String, dynamic>>? mapData = [];

  Map<String, double> calcularTotales() {
    mapData = widget.data;
    totalKilos =0;
    valorPagar =0;
    for (var item in mapData!) {
      totalKilos += item["cantidad"];
      valorPagar += item["total"];
      if (!widget.isDetalle) {
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
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Recolector: ${widget.recolectorModel.nombres} ${widget.recolectorModel.apellidos}"),
                      Text(
                          "Identificación: ${widget.recolectorModel.identificacion}"),
                      Text("Kilos ingresados: $totalKilos"),
                      Text(
                          "Valor a pagar: ${currencyFormat.format(valorPagar.toInt())}"),
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
                  mapData!.length,
                  (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: widget.isDetalle? null:() {
                              final ctrl1 = TextEditingController();
                              final ctrl2 = TextEditingController();
                              final int indexS = mapData![index]["idMaterial"];
                              ctrl1.text =
                                  mapData![index]["cantidad"].toString();
                              ctrl2.text =
                                  mapData![index]["precioUnidad"].toString();
                              dialogButton(
                                  isScrollControlled: false,
                                  context: context,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Text("Peso registrado"),
                                        InputWidget(
                                            controller: ctrl1,
                                            type: TextInputType.number,
                                            list: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            hintText: "",
                                            icon: (Icons.line_weight),
                                            onChanged: (e) {}),
                                        const SizedBox(height: 10),
                                        const Text(
                                            "Valor por unidad registrado"),
                                        InputWidget(
                                            controller: ctrl2,
                                            hintText: "",
                                            type: TextInputType.number,
                                            list: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            icon: (Icons.monetization_on),
                                            onChanged: (e) {}),
                                        const SizedBox(height: 10),
                                        BtnWidget(
                                            action: () {
                                              Map<String, dynamic> dt = {};
                                              for (var data in mapData!) {
                                                if (mapData![index]
                                                        ["idMaterial"] ==
                                                    indexS) {
                                                  dt = ({
                                                    "idRecolector":
                                                        data["idRecolector"],
                                                    "idMinorista":
                                                        data["idMinorista"],
                                                    "idMaterial":
                                                        data["idMaterial"],
                                                    "fechaAlimenta":
                                                        data["fechaAlimenta"],
                                                    "cantidad": double.parse(
                                                        ctrl1.text),
                                                    "precioUnidad":
                                                        double.parse(
                                                            ctrl2.text),
                                                    "total": double.parse(
                                                            ctrl1.text) *
                                                        double.parse(
                                                            ctrl2.text),
                                                    "material":
                                                        data["material"],
                                                    "valor":
                                                        double.parse(ctrl2.text)
                                                  });
                                                }
                                              }
                                              mapData![index] = dt;
                                              calcularTotales();
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            txt: "Actualizar",
                                            enabled: true)
                                      ],
                                    ),
                                  ));
                            },
                            child: _row(
                                txt1: mapData![index]["material"].toString(),
                                txt2: mapData![index]["cantidad"].toString(),
                                txt3: (currencyFormat.format(
                                        mapData![index]["precioUnidad"]))
                                    .toString(),
                                txt4: (currencyFormat
                                        .format(mapData![index]["total"]))
                                    .toString()),
                          ),
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
                      final r = await _compraC.realizarCompra(mapData!);
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
      
          ],
        ),
      );

  Widget _row({
    required String txt1,
    required String txt2,
    required String txt3,
    required String txt4,
  }) =>
      Container(
        color: Colors.transparent,
        child: Padding(
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
                  child: Container(
                      alignment: Alignment.center, child: Text(txt4))),
            ],
          ),
        ),
      );
}
