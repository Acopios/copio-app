// ignore_for_file: must_be_immutable

part of 'venta_cubit.dart';

class VentaState extends Equatable {
  final List<MaterialCustom>? materiales;
  final List<MaterialModel>? list;
  final List<MaterialModel>? listTem;
  late bool loading;
  late bool isFilter;

  VentaState(
      {this.materiales,
      this.list,
      this.listTem,
      this.isFilter = false,
      this.loading = false});

  @override
  List<Object?> get props => [materiales, listTem, list, isFilter, loading];

  VentaState copyWith(
          {List<MaterialCustom>? materiales,
          List<MaterialModel>? listTem,
          List<MaterialModel>? list,
          bool? loading,
          bool? isFilter}) =>
      VentaState(
          materiales: materiales ?? this.materiales,
          isFilter: isFilter ?? this.isFilter,
          list: list ?? this.list,
          listTem: listTem ?? this.listTem,
          loading: loading ?? this.loading);
}
