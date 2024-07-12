// ignore_for_file: use_build_context_synchronously

import 'package:acopios/src/core/custom_input_formatter.dart';
import 'package:acopios/src/core/utils.dart';
import 'package:acopios/src/data/model/mayorista_model.dart';
import 'package:acopios/src/ui/blocs/mayorista/mayorista_cubit.dart';
import 'package:acopios/src/ui/helpers/alert_dialog_helper.dart';
import 'package:acopios/src/ui/widgets/btn_widget.dart';
import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:acopios/src/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgregarMayorista extends StatefulWidget {
  final bool isEdit;
  final MayoristaModel? mayoristaModel;
  const AgregarMayorista({super.key, this.isEdit = false, this.mayoristaModel});

  @override
  State<AgregarMayorista> createState() => _AgregarMayoristaState();
}

class _AgregarMayoristaState extends State<AgregarMayorista> {
  late MayoristaCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = MayoristaCubit();
    if (widget.isEdit) {
      _cubit.initDataEdit(widget.mayoristaModel!);
    }
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
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    InputWidget(
                        controller: c.txt,
                        hintText: "Nombre",
                        icon: (Icons.person),
                        onChanged: (e) {
                          c.enbaled();
                        }),
                    const SizedBox(height: 10),
                    InputWidget(
                        controller: c.nit,
                        list: [CustomInputFormatter()],
                        hintText: "Nit",
                        icon: (Icons.card_travel_sharp),
                        onChanged: (e) {
                          c.enbaled();
                        }),
                    const SizedBox(height: 10),
                    InputWidget(
                        controller: c.representante,
                        hintText: "Representante",
                        icon: (Icons.person),
                        onChanged: (e) {
                          c.enbaled();
                        }),
                    const SizedBox(height: 10),
                    InputWidget(
                        controller: c.direccion,
                        hintText: "Dirección",
                        icon: (Icons.location_city),
                        onChanged: (e) {
                          c.enbaled();
                        }),
                    const SizedBox(height: 10),
                    InputWidget(
                        controller: c.email,
                        hintText: "Correo electrónico",
                        icon: (Icons.email),
                        type: TextInputType.emailAddress,
                        onChanged: (e) {
                          c.enbaled();
                        }),
                    const SizedBox(height: 10),
                    InputWidget(
                        controller: c.telefono,
                        hintText: "Telefono",
                        type: TextInputType.number,
                        list: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ],
                        icon: (Icons.phone),
                        onChanged: (e) {
                          c.enbaled();
                        }),
                    const SizedBox(height: 150),
                    BtnWidget(
                        action: () async {
                          final r = await _cubit.crearMayorista(
                              edit: widget.isEdit,
                              idM: widget.isEdit
                                  ? widget.mayoristaModel!.idMayorista
                                  : null);
                          if (r) {
                            Navigator.pop(context);
                          } else {
                            info(context, messageError, () {
                              Navigator.pop(context);
                            });
                          }
                        },
                        txt: widget.isEdit ? "Editar" : "Registrar",
                        enabled: state.enabled),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
