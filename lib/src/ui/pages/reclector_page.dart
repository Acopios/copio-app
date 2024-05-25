// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/ui/blocs/recolector/recolector_cubit.dart';
import 'package:acopios/src/ui/helpers/alert_dialog_helper.dart';
import 'package:acopios/src/ui/pages/home_page.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/btn_widget.dart';

class RecolectorPagState extends StatefulWidget {
  const RecolectorPagState({super.key});

  @override
  State<RecolectorPagState> createState() => _RecolectorPagStateState();
}

class _RecolectorPagStateState extends State<RecolectorPagState> {
  late Size _size;

  late RecolectorCubit _recolectorCubit;

  @override
  void initState() {
    super.initState();
    _recolectorCubit = RecolectorCubit();
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
                icon: Icons.phone,
                onChanged: (e) {
                  _recolectorCubit.isEnabled();
                }),
            _space(10),
            BlocBuilder<RecolectorCubit, RecolectorState>(
              builder: (context, state) {
                return BtnWidget(
                    enabled: state.enabled,
                    action: () async {
                      final r = await _recolectorCubit.crearRecolector();
                      if (r) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => HomePage()),
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
                    txt: "Crear");
              },
            ),
          ],
        ),
      );

  Widget _space(double space) => SizedBox(height: space);
}
