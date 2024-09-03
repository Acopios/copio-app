import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'src/ui/pages/login_page.dart';

void main() {
  
    initializeDateFormatting('es_ES', null).then((_) {
  });

  return runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Acopios',
      debugShowCheckedModeBanner: false,
      home: LoginPage());
  }
}