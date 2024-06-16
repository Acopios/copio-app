// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/ui/blocs/mayorista/mayorista_cubit.dart';
import 'package:acopios/src/ui/helpers/alert_dialog_helper.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgregarMayorista extends StatefulWidget {
  const AgregarMayorista({super.key});

  @override
  State<AgregarMayorista> createState() => _AgregarMayoristaState();
}

class _AgregarMayoristaState extends State<AgregarMayorista> {
  late MayoristaCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = MayoristaCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(elevation: 8, title: const Text("Agregar mayorista")),
        body: BlocBuilder<MayoristaCubit, MayoristaState>(
          builder: (context, state) {
            return Stack(
              children: [
                _body(),
                Visibility(visible: state.loading, child: const LoadingWidget())
              ],
            );
          },
        ),
      )),
    );
  }

  Widget _body() => BlocBuilder<MayoristaCubit, MayoristaState>(
        builder: (context, state) {
          final c = context.read<MayoristaCubit>();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                InputWidget(
                    controller: c.txt,
                    hintText: "Nombre",
                    icon: (Icons.person),
                    onChanged: (e) {
                      c.enbaled(
                          e.toString().isNotEmpty && e.toString().length >= 4);
                    }),
                const Expanded(child: SizedBox()),
                BtnWidget(
                    action: () async {
                      final r = await _cubit.crearMayorista();
                      if (r) {
                        Navigator.pop(context);
                      } else {
                        info(context, "No fue posible clear el mayorista", () {
                          Navigator.pop(context);
                        });
                      }
                    },
                    txt: "Registrar",
                    enabled: state.enabled),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      );
}
