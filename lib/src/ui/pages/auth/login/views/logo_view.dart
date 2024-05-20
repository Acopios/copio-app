import 'package:flutter/material.dart';

class LogoView extends StatelessWidget {
  LogoView({super.key});

  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return Center(
        child: Container(
            margin: EdgeInsets.only(top: _size.height * .05),
            child: Icon(
              Icons.recycling_outlined,
              color: Colors.green[300],
              size: _size.height * .2,
            )));
  }
}
