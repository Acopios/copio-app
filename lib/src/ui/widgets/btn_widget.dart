import 'package:flutter/material.dart';

class BtnWidget extends StatelessWidget {
  final Function() action;
  final bool enabled;
  final String txt;
  const BtnWidget(
      {super.key,
      required this.action,
      required this.txt,
      required this.enabled});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: enabled ? action : null, child: Text(txt));
  }
}
