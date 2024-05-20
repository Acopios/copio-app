import 'package:acopios/src/ui/pages/home/home_page.dart';
import 'package:acopios/src/ui/pages/home/minorista/cubit/minorista_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MinoristaPage extends StatefulWidget {
  const MinoristaPage({super.key});

  @override
  State<MinoristaPage> createState() => _MinoristaPageState();
}

class _MinoristaPageState extends State<MinoristaPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MinoristaCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text("Añadir minorista")),
        body: BlocBuilder<MinoristaCubit, MinoristaState>(
          builder: (context, state) {
            final c = context.read<MinoristaCubit>();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  _input(txtHelper: "Nombres", txt: c.txt1, onChanged: (e) {}),
                  _input(
                      txtHelper: "Apellidos", txt: c.txt2, onChanged: (e) {}),
                  _input(
                      txtHelper: "Identificacion",
                      txt: c.txt3,
                      onChanged: (e) {}),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final r = await c.crearReclector();
                        if (r.success!) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomePage()),
                              (route) => false);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Por favor revisa tus credenciales"),
                          ));
                        }
                      },
                      child: Text("Crear")),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _input(
          {required String txtHelper,
          required TextEditingController txt,
          required Function(dynamic e) onChanged}) =>
      Container(
        margin: EdgeInsets.only(top: 10),
        child: TextField(
          controller: txt,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: txtHelper,
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder(),
          ),
        ),
      );
}
