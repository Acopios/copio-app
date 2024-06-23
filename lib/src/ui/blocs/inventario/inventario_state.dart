// ignore_for_file: must_be_immutable

part of 'inventario_cubit.dart';

class InventarioState extends Equatable {
  late bool loading;
  late bool isFilter;
  final List<InventarioModel>? list;
  final List<InventarioModel>? listTemp;

  InventarioState(
      {this.isFilter = false, this.loading = false, this.list, this.listTemp});

  @override
  List<Object?> get props => [isFilter, loading, list, listTemp];

  InventarioState copyWith(
          {bool? loading,
          bool? isFilter,
          List<InventarioModel>? list,
          List<InventarioModel>? listTemp}) =>
      InventarioState(
          isFilter: isFilter ?? this.isFilter,
          list: list ?? this.list,
          listTemp: listTemp ?? this.listTemp,
          loading: loading ?? this.loading);
}
