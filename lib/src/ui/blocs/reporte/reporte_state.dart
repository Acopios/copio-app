// ignore_for_file: must_be_immutable

part of 'reporte_cubit.dart';

class ReporteState extends Equatable {
  final DateTime? fechaI;
  final DateTime? fechaF;
  final bool showDate;
  final List<PrecioModel>? list;
  late bool loadingReport;
  final List<RecolectorModel>? listRecolectores;
  final List<MayoristaModel>? mayorista;

  ReporteState(
      {this.fechaF,
      this.fechaI,
      this.showDate = false,
      this.list,
      this.listRecolectores,
      this.mayorista,
      this.loadingReport = false});

  @override
  List<Object?> get props => [
        fechaF,
        fechaI,
        showDate,
        list,
        loadingReport,
        listRecolectores,
        mayorista,
        
      ];

  ReporteState copyWith(
          {DateTime? fechaI,
          DateTime? fechaF,
          bool? loadingReport,
          List<PrecioModel>? list,
          List<MayoristaModel>? mayorista,
          List<RecolectorModel>? listRecolectores,
          bool? showDate}) =>
      ReporteState(
          loadingReport: loadingReport ?? this.loadingReport,
          fechaF: fechaF ?? this.fechaF,
          fechaI: fechaI ?? this.fechaI,
          listRecolectores: listRecolectores ?? this.listRecolectores,
          list: list ?? this.list,
          mayorista: mayorista ?? this.mayorista,
          showDate: showDate ?? this.showDate);
}
