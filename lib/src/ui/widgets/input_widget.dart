import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType type;
  final bool enabled;
  final Widget?  suffixIcon;
  final List<TextInputFormatter>? list;
  final Function(dynamic e) onChanged;
  const InputWidget(
      {super.key,
      this.list,
      this.enabled = true,
      this.suffixIcon,
      required this.controller,
      required this.hintText,
      required this.icon,
      this.type = TextInputType.text,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: type,
      inputFormatters: list,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon:suffixIcon ,
        enabled: enabled,
        contentPadding: const EdgeInsets.all(0),
        prefixIcon: Icon(icon),
        disabledBorder: OutlineInputBorder(),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
