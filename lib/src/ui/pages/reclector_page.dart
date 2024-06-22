// ignore_for_file: use_build_context_synchronously


import 'package:acopios/src/ui/blocs/recolector/recolector_cubit.dart';
import 'package:acopios/src/ui/helpers/alert_dialog_helper.dart';
import 'package:acopios/src/ui/helpers/dialog_helper.dart';
import 'package:acopios/src/ui/pages/home_page.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils.dart';
import '../../data/model/precio_material.dart';
import '../blocs/material/material_cubit.dart';
import '../widgets/btn_widget.dart';

class RecolectorPagState extends StatefulWidget {
  const RecolectorPagState({super.key});

  @override
  State<RecolectorPagState> createState() => _RecolectorPagStateState();
}

class _RecolectorPagStateState extends State<RecolectorPagState> {
  late Size _size;

  late RecolectorCubit _recolectorCubit;
  late MaterialCubit _cubit;

  late Future<List<PrecioMaterial>> _future;
  @override
  void initState() {
    super.initState();
    _recolectorCubit = RecolectorCubit();
    _cubit = MaterialCubit();
    _init(false);
  }

  _init(enabled) {
    _future = _cubit.precioMateriales();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => _recolectorCubit,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 8,
            title: const Text("Crear recolector"),
          ),
          body: BlocBuilder<RecolectorCubit, RecolectorState>(
            builder: (context, state) {
              return Stack(
                children: [
                  _body(),
                  Visibility(
                      visible: state.loading, child: const LoadingWidget())
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _body() => Container(
        margin:
            EdgeInsets.symmetric(horizontal: _size.width * .1, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _space(30),
            InputWidget(
                controller: _recolectorCubit.name,
                hintText: "Nombres",
                icon: Icons.person,
                onChanged: (e) {
                  _recolectorCubit.isEnabled();
                }),
            _space(10),
            InputWidget(
                controller: _recolectorCubit.lastname,
                hintText: "Apelllidos",
                icon: Icons.person,
                onChanged: (e) {
                  _recolectorCubit.isEnabled();
                }),
            _space(10),
            InputWidget(
                controller: _recolectorCubit.ide,
                hintText: "Identificacion",
                list: [FilteringTextInputFormatter.digitsOnly],
                type: TextInputType.number,
                icon: Icons.card_travel_sharp,
                onChanged: (e) {
                  _recolectorCubit.isEnabled();
                }),
            _space(10),
            InputWidget(
                controller: _recolectorCubit.address,
                hintText: "Dirección",
                icon: Icons.location_city,
                onChanged: (e) {
                  _recolectorCubit.isEnabled();
                }),
            _space(10),
            InputWidget(
                controller: _recolectorCubit.phone,
                hintText: "Número telefono",
                list: [FilteringTextInputFormatter.digitsOnly],
                type: TextInputType.number,
                icon: Icons.phone,
                onChanged: (e) {
                  _recolectorCubit.isEnabled();
                }),
            _space(10),
            GestureDetector(
              onTap: () {
                dialogButton(
                    context: context,
                    child: Expanded(
                        child: FutureBuilder<List<PrecioMaterial>>(
                      future: _future,
                      builder: (_, s) {
                        if (!s.hasData) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        final list = s.data ?? [];
                        if (list.isEmpty) {
                          return const Center(
                            child: Text("Sin información"),
                          );
                        }
                        return ListView(
                          children: List.generate(
                              list.length,
                              (index) => Column(
                                    children: [
                                      ExpansionTile(
                                        leading:
                                            const Icon(Icons.monetization_on),
                                        title: Text(
                                            'Lista de precios  ${list[index].idAsignacion}'),
                                        children: List.generate(
                                          list[index].precios.length,
                                          (index2) => ListTile(
                                            title: Text(list[index]
                                                .precios[index2]
                                                .idMaterial
                                                .nombre),
                                            subtitle: Text(currencyFormat
                                                .format(list[index]
                                                    .precios[index2]
                                                    .valor
                                                    .toInt())),
                                          ),
                                        )..add(
                                            BtnWidget(
                                                action: () {
                                                  setState(() {
                                                    _recolectorCubit.idLista =
                                                        list[index]
                                                            .idAsignacion;
                                                    _recolectorCubit
                                                            .lsita.text =
                                                        "Lista de precio ${list[index].idAsignacion}";
                                                  });
                                                  Navigator.pop(context);
                                                      _recolectorCubit.isEnabled();
                                                },
                                                txt: "Asignar",
                                                enabled: true),
                                          ),
                                      ),
                                    ],
                                  )),
                        );
                      },
                    )), isScrollControlled: false);
              },
              child: InputWidget(
                  enabled: false,
                  controller: _recolectorCubit.lsita,
                  hintText: "Asignar lista de precios",
                  list: [FilteringTextInputFormatter.digitsOnly],
                  type: TextInputType.name,
                  icon: Icons.monetization_on,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                  onChanged: (e) {
                    _recolectorCubit.isEnabled();
                  }),
            ),
            _space(10),
            BlocBuilder<RecolectorCubit, RecolectorState>(
              builder: (context, state) {
                return Center(
                  child: BtnWidget(
                      enabled: state.enabled,
                      action: () async {
                        final r = await _recolectorCubit.crearRecolector();
                        if (r) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomePage()),
                              (route) => false);
                        } else {
                          alert(
                              context,
                              const Column(
                                children: [
                                  Text("No fue posible crear el recolector")
                                ],
                              ), action1: () {
                            Navigator.pop(context);
                          });
                        }
                      },
                      txt: "Crear"),
                );
              },
            ),
          ],
        ),
      );

  Widget _space(double space) => SizedBox(height: space);
}
