// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/data/model/mayorista_model.dart';
import 'package:acopios/src/data/model/recolector_model.dart';
import 'package:acopios/src/ui/blocs/reporte/reporte_cubit.dart';
import 'package:acopios/src/ui/helpers/alert_dialog_helper.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<Map<String, dynamic>> _dropdownItems = [
    {"name": "Reporte de compra general", "value": "g"},
    {"name": "Reporte de compra por recolector", "value": "i"},
    {"name": "Reporte de venta general", "value": "vg"},
    {"name": "Reporte de venta por mayorista", "value": "vm"},
    {"name": "Reporte de reuso", "value": "r"},
  ];

  String? _selectedItem;
  RecolectorModel? _selectedItemReco;
  MayoristaModel? _selectedItemMayo;

  late Size _size;

  late ReporteCubit _reporteCubitM;

// Assuming data is extracted and stored in a list named 'data'

  @override
  void initState() {
    super.initState();

    _reporteCubitM = ReporteCubit();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => _reporteCubitM,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(elevation: 8, title: const Text("Reportes")),
        body: BlocBuilder<ReporteCubit, ReporteState>(
          builder: (context, state) {
            return Stack(
              children: [
                _body(),
                Visibility(
                    visible: state.loadingReport, child: const LoadingWidget())
              ],
            );
          },
        ),
      )),
    );
  }

  Widget _body() => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(height: _size.height * .05),
            _drop(),
            BlocBuilder<ReporteCubit, ReporteState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.showDate,
                  child: Column(
                    children: [
                      SizedBox(height: _size.height * .02),
                      Visibility(
                          visible: state.listRecolectores != null &&
                              state.listRecolectores!.isNotEmpty,
                          child: Column(
                            children: [
                              _dropRecolectores(),
                              SizedBox(height: _size.height * .02),
                            ],
                          )),
                      Visibility(
                          visible: state.mayorista != null &&
                              state.mayorista!.isNotEmpty,
                          child: Column(
                            children: [
                              _dropMayoristas(),
                              SizedBox(height: _size.height * .02),
                            ],
                          )),
                      _selectDate(),
                      SizedBox(height: _size.height * .02),
                      _options(),
                    ],
                  ),
                );
              },
            ),
            _listReport()
          ],
        ),
      );
  Widget _drop() => BlocBuilder<ReporteCubit, ReporteState>(
        builder: (context, state) {
          return Center(
            child: DropdownButtonFormField<String>(
              value: _selectedItem,
              padding: const EdgeInsets.all(0.0), // Adjust padding as needed
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: const Text('Selecciona el reporte a generar'),
              items: _dropdownItems.map((Map<String, dynamic> item) {
                final String reportName = item['name'] as String;
                final String reportValue = item['value'] as String;

                return DropdownMenuItem<String>(
                  value: reportValue,
                  child: Text(reportName),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedItem = newValue!;
                  if (newValue == 'g') {
                    context.read<ReporteCubit>().showDate(true);
                    _reporteCubitM.clearR2();
                  } else if (newValue == 'i') {
                    context.read<ReporteCubit>().showDate(true);
                    _selectedItemReco = null;
                    _selectedItemMayo = null;

                    _reporteCubitM.obtenerRecolectores();
                  } else if (newValue == 'vg') {
                    context.read<ReporteCubit>().showDate(true);
                    _selectedItemReco = null;
                    _selectedItemMayo = null;
                    _reporteCubitM.clearR2();
                  } else if (newValue == 'vm') {
                    context.read<ReporteCubit>().showDate(true);
                    _selectedItemReco = null;
                    _selectedItemMayo = null;
                    _reporteCubitM.clearR2();
                    _reporteCubitM.obtenerMayoristas();
                  }
                });
              },
            ),
          );
        },
      );
  Widget _dropRecolectores() => BlocBuilder<ReporteCubit, ReporteState>(
        builder: (context, state) {
          return Center(
            child: DropdownButtonFormField<RecolectorModel>(
              value: _selectedItemReco,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: const Text('Selecciona el recolector'),
              items: state.listRecolectores!.map((RecolectorModel item) {
                return DropdownMenuItem<RecolectorModel>(
                  value: item,
                  child: Text(item.nombres ?? ""),
                );
              }).toList(),
              onChanged: (RecolectorModel? newValue) {
                setState(() {
                  _selectedItemReco = newValue;
                });
              },
            ),
          );
        },
      );
  Widget _dropMayoristas() => BlocBuilder<ReporteCubit, ReporteState>(
        builder: (context, state) {
          return Center(
            child: DropdownButtonFormField<MayoristaModel>(
              value: _selectedItemMayo,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: const Text('Selecciona el mayorista'),
              items: state.mayorista!.map((MayoristaModel item) {
                return DropdownMenuItem<MayoristaModel>(
                  value: item,
                  child: Text(item.nombre ?? ""),
                );
              }).toList(),
              onChanged: (MayoristaModel? newValue) {
                setState(() {
                  _selectedItemMayo = newValue;
                });
              },
            ),
          );
        },
      );
  Widget _selectDate() => BlocBuilder<ReporteCubit, ReporteState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Indica las fechas del reporte"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _date(
                      state.fechaI != null
                          ? DateFormat.MMMEd('es').format(state.fechaI!)
                          : "Fecha incial", () async {
                    final dateInitial = await getDate(context);
                    _reporteCubitM.addFechaI(dateInitial!);
                  }),
                  _date(
                      state.fechaF != null
                          ? DateFormat.MMMEd('es').format(state.fechaF!)
                          : "Fecha final",
                      (state.fechaI == null)
                          ? () {}
                          : () async {
                              final dateFinal =
                                  await getDate(context, date: state.fechaI);
                              _reporteCubitM.addFechaF(dateFinal!);
                            })
                ],
              ),
            ],
          );
        },
      );
  Widget _date(String date, Function() action) => GestureDetector(
        onTap: action,
        child: Container(
          width: _size.width * .4,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [const Icon(Icons.calendar_month), Text("  $date")],
          ),
        ),
      );

  Widget _options() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _btns(),
          _btnf(),
        ],
      );

  Widget _btns() => BlocBuilder<ReporteCubit, ReporteState>(
        builder: (context, state) {
          return BtnWidget(
              action: () async {
                if (_selectedItem == "g") {
                  _reporteCubitM.obtenerReporte();
                  context.read<ReporteCubit>().showDate(false);
                }
                if (_selectedItem == "i") {
                  _reporteCubitM.obtenerReporteIdividual(
                      _selectedItemReco!.idRecolector!);
                  context.read<ReporteCubit>().showDate(false);
                }
                if (_selectedItem == "vg") {
                  _reporteCubitM.obtenerReporteVenta();
                  context.read<ReporteCubit>().showDate(false);
                }
                if (_selectedItem == "vm") {
                  _reporteCubitM.obtenerReporteIdividualMay(
                      _selectedItemMayo!.idMayorista!);
                  context.read<ReporteCubit>().showDate(false);
                }
              },
              txt: "Generar Reporte",
              enabled: true);
        },
      );
  Widget _btnf() => BlocBuilder<ReporteCubit, ReporteState>(
        builder: (context, state) {
          return TextButton(
            onPressed: () {
              context.read<ReporteCubit>().showDate(false);
            },
            child: const Text("Cancelar"),
          );
        },
      );

  Widget _listReport() => BlocBuilder<ReporteCubit, ReporteState>(
        builder: (context, state) {
          return state.list == null || state.list!.isEmpty
              ?  SizedBox(child: Visibility(
                visible: state.list == null ||  state.list!.isEmpty,
                child: Container(
                
                margin: const EdgeInsets.only(top: 200),
                child: const Text("Sin información"))) ,)
              : Expanded(
                  child: ListView(
                  children: [
                    SizedBox(height: _size.height * .05),
                    const Divider(),
                    _row(
                        txt1: "Material",
                        txt2: "KG",
                        txt3: "Precio KG",
                        txt4: "Total"),
                    const Divider(),

                    ...List.generate(
                        state.list!.length,
                        (index) => Column(
                              children: [
                                _row(
                                    txt1: state.list![index].idMaterial.nombre,
                                    txt2:
                                        state.list![index].cantidad!.toString(),
                                    txt3: currencyFormat.format(state
                                        .list![index].precioUnidad!
                                        .toInt()),
                                    txt4: currencyFormat.format(
                                        state.list![index].total!.toInt())),
                                const Divider()
                              ],
                            )),
                    SizedBox(height: _size.height * .05),
                    BtnWidget(
                        action: () async {
                          if (_selectedItem == "g") {
                            Permission.manageExternalStorage
                                .request()
                                .then((value) async {
                              if (value.isGranted) {
                                final r =
                                    await _reporteCubitM.crearReporteGeneral();

                                if (r) {
                                  info(context,
                                      "Reporte  generado con éxito, lo puedes observar en Descargas",
                                      () {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  info(context,
                                      "No fue posible generar el reporte", () {
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            });
                          }
                          if (_selectedItem == "i") {
                            Permission.manageExternalStorage
                                .request()
                                .then((value) async {
                              if (value.isGranted) {
                                final r = await _reporteCubitM
                                    .crearReporteInividual(_selectedItemReco!);

                                if (r) {
                                  info(context,
                                      "Reporte  generado con éxito, lo puedes observar en Descargas",
                                      () {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  info(context,
                                      "No fue posible generar el reporte", () {
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            });
                          }
                          if (_selectedItem == "vg") {
                            Permission.manageExternalStorage
                                .request()
                                .then((value) async {
                              if (value.isGranted) {
                                final r = await _reporteCubitM
                                    .crearReporteGeneralVenta();

                                if (r) {
                                  info(context,
                                      "Reporte  generado con éxito, lo puedes observar en Descargas",
                                      () {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  info(context,
                                      "No fue posible generar el reporte", () {
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            });
                          }
                          if (_selectedItem == "vm") {
                            Permission.manageExternalStorage
                                .request()
                                .then((value) async {
                              if (value.isGranted) {
                                final r = await _reporteCubitM
                                    .crearReporteInividualMayorista(
                                        _selectedItemMayo!);

                                if (r) {
                                  info(context,
                                      "Reporte  generado con éxito, lo puedes observar en Descargas",
                                      () {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  info(context,
                                      "No fue posible generar el reporte", () {
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            });
                          }
                        },
                        txt: "Descargar Reporte",
                        enabled: true)
                  ],
                ));
        },
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
