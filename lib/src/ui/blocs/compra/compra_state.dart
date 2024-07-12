// ignore_for_file: must_be_immutable

part of 'compra_cubit.dart';

class CompraState extends Equatable {
  final List<MaterialCustom>? materiales;
  late bool loading;
  late bool isFilter;
  final List<PrecioModel>? precios;
  final List<PrecioModel>? preciosTemp;

  CompraState({
    this.materiales,
    this.isFilter = false,
    this.loading = false,
    this.precios,
    this.preciosTemp,
  });

  @override
  List<Object?> get props => [materiales, loading, isFilter, preciosTemp];

  CompraState copyWith({
    List<MaterialCustom>? materiales,
    bool? loading,
    bool? isFilter,
    List<PrecioModel>? precios,
    List<PrecioModel>? preciosTemp,
  }) =>
      CompraState(
          materiales: materiales ?? this.materiales,
          isFilter: isFilter ?? this.isFilter,
          loading: loading ?? this.loading,
          precios: precios ?? this.precios,
          preciosTemp: preciosTemp ?? this.preciosTemp);
}
