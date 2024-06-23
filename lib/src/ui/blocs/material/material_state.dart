// ignore_for_file: must_be_immutable

part of 'material_cubit.dart';

class MaterialState extends Equatable {
  late bool loading;
  late bool isFilter;
  final List<MaterialModel>? list;
  final List<MaterialModel>? listTemp;
  MaterialState({
    this.loading = false,
    this.list,
    this.listTemp,
    this.isFilter = false,
  });

  @override
  List<Object?> get props => [loading, list, listTemp, isFilter];
  MaterialState copyWith({
    bool? loading,
    bool? isFilter,
    List<MaterialModel>? list,
    List<MaterialModel>? listTemp,
  }) =>
      MaterialState(
          loading: loading ?? this.loading,
          isFilter: isFilter ?? this.isFilter,
          list: list ?? this.list,
          listTemp: listTemp ?? this.listTemp);
}
