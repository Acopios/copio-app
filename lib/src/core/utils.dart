import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

///[currencyFormat]  genera un formato de moneda
final NumberFormat currencyFormat =
    NumberFormat.currency(locale: 'es', symbol: '');

String messageError = "";

///[getDate] genera un calendario
Future<DateTime?> getDate(BuildContext context, {DateTime? date}) =>
    showDatePicker(
      context: context,
      firstDate: date ?? DateTime.utc(2011, 3, 14),
      lastDate: DateTime.now(),
    );

///[crearExcel] para generar y  guardar un excel

Future<void> crearExcel({
  required List<CellValue> columnas,
  required List<Map<String, dynamic>> userData,
  required List<List<TextCellValue>> body,
}) async {
  // Solicitar permiso de almacenamiento
  var status = await Permission.manageExternalStorage.request();
  if (!status.isGranted) {
    log("Permiso de almacenamiento no concedido");
    return;
  }

  var excel = Excel.createExcel();

  Sheet sheetObject = excel['Reporte'];

  // Agregar información del usuario
  for (var i in userData) {
    sheetObject
        .appendRow([TextCellValue(i["name"]), TextCellValue(i["value"])]);
  }

  // Agregar columnas
  List<CellValue> row1 = [];
  for (var i in columnas) {
    row1.add(i);
  }
  sheetObject.appendRow(row1);

  // Agregar registros del reporte
  for (var item in body) {
    sheetObject.appendRow(item);
  }

  // Obtener la ruta del directorio de almacenamiento temporal
  Directory? directory = await getTemporaryDirectory();
  String outputPath =
      "${directory.path}/Reporte_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}_${DateTime.now().hour}_${DateTime.now().minute}_${DateTime.now().second}.xlsx";

  // Guardar el archivo Excel
  File(outputPath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(excel.encode()!);

  // Compartir el archivo Excel
  await Share.shareXFiles([XFile(outputPath)], text: 'Reporte generado');
}
