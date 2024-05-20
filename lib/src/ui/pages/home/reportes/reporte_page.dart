import 'package:acopios/src/ui/pages/home/material_list/materiales_model.dart';
import 'package:acopios/src/ui/pages/home/minorista/recolectores_model.dart';
import 'package:acopios/src/ui/pages/home/reportes/cubit/reportes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportesPage extends StatefulWidget {
  final BodyReco bodyReco;
  const ReportesPage({super.key, required this.bodyReco});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  late ReportesCubit reportesCubit;

  late Future<List<BodyMaterial>> _future;

  @override
  void initState() {
    super.initState();
    reportesCubit = ReportesCubit();
    init();
  }

  init() {
    _future = reportesCubit.obtenerMateriales();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => reportesCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Agregar reporte"),
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Recolector: ${widget.bodyReco.nombres!.toUpperCase()} ${widget.bodyReco.apellidos!.toUpperCase()}"),
          const Divider(),
          const Text("Materiales"),
          FutureBuilder<List<BodyMaterial>>(
              future: _future,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
                return DropdownButtonFormField(
                  items: snapshot.data!.map((bodyMaterial) {
                    return DropdownMenuItem<BodyMaterial>(
                      value: bodyMaterial,
                      child: Text(bodyMaterial.nombre!),
                    );
                  }).toList(),
                  hint: Text("Seleccionar"),
                  onChanged: (e) {
                    reportesCubit.materialSelected = e;
                    reportesCubit.matSeleted = true;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder()),
                );
              }),
          SizedBox(height: 10),
          reportesCubit.matSeleted
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Valor estimado: ${reportesCubit.materialSelected!.valor}"),
                    Text("Código: ${reportesCubit.materialSelected!.codigo}"),
                    Divider(),
                    TextField(
                      onChanged: (e) {
                        setState(() {});
                      },
                      controller: reportesCubit.txt1,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                          hintText: "Valor venta KG",
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (e) {
                        setState(() {});
                      },
                      controller: reportesCubit.txt2,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                          hintText: "Kilos a regisrar",
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10),
                    Text(
                        "Total: ${(reportesCubit.txt1.text.isEmpty || reportesCubit.txt2.text.isEmpty) ? "0" : int.parse(reportesCubit.txt1.text) * int.parse(reportesCubit.txt2.text)}"),
                    const SizedBox(height: 10),
                    Center(
                        child: ElevatedButton(
                            onPressed: () {
                              reportesCubit.report(widget.bodyReco.idRecolector!);
                              setState(() {
                                
                              });
                            }, child: Text("Reportar")))
                  ],
                )
              : const SizedBox()
        ],
      ));
}
