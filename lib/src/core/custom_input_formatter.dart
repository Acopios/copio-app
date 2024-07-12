import 'package:flutter/services.dart';

class CustomInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'^\d*-?\d?$');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
