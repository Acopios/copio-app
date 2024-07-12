part of 'add_material_cubit.dart';

 class AddMaterialState extends Equatable {
  final List<MaterialCustom>? materiales;
  final List<MaterialModel>? list;
  final List<MaterialModel>? listTem;
  late bool loading;
  late bool isFilter;

  AddMaterialState(
      {this.materiales,
      this.list,
      this.listTem,
      this.isFilter = false,
      this.loading = false});

  @override
  List<Object?> get props => [materiales, listTem, list, isFilter, loading];

  AddMaterialState copyWith(
          {List<MaterialCustom>? materiales,
          List<MaterialModel>? listTem,
          List<MaterialModel>? list,
          bool? loading,
          bool? isFilter}) =>
      AddMaterialState(
          materiales: materiales ?? this.materiales,
          isFilter: isFilter ?? this.isFilter,
          list: list ?? this.list,
          listTem: listTem ?? this.listTem,
          loading: loading ?? this.loading);
}



