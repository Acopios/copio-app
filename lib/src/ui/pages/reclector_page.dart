import 'package:acopios/src/ui/widgets/input_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/btn_widget.dart';

class RecolectorPagState extends StatefulWidget {
  const RecolectorPagState({super.key});

  @override
  State<RecolectorPagState> createState() => _RecolectorPagStateState();
}

class _RecolectorPagStateState extends State<RecolectorPagState> {
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          title: Text("Crear recolector"),
        ),
        body: _body(),
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
                controller: TextEditingController(),
                hintText: "Nombres",
                icon: Icons.person,
                onChanged: (e) {}),
            _space(10),
            InputWidget(
                controller: TextEditingController(),
                hintText: "Apelllidos",
                icon: Icons.person,
                onChanged: (e) {}),
            _space(10),
            InputWidget(
                controller: TextEditingController(),
                hintText: "Identificacion",
                icon: Icons.card_travel_sharp,
                onChanged: (e) {}),
            _space(10),
            BtnWidget(
                enabled: true,
                action: () {
                  Navigator.pop(context);
                },
                txt: "Crear"),
          ],
        ),
      );

  Widget _space(double space) => SizedBox(height: space);
}
