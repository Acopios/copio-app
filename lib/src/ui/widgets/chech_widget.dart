import 'package:flutter/material.dart';

class CheckWidget extends StatelessWidget {
  final bool enabled;
  final String txt;
  final Function(dynamic e) onChanged;
  const CheckWidget(
      {super.key,
      required this.enabled,
      required this.onChanged,
      required this.txt});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
        title: Text(txt), value: enabled, onChanged: onChanged);
  }
}
