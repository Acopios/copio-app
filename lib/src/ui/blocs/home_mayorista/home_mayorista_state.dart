// ignore_for_file: must_be_immutable

part of 'home_mayorista_cubit.dart';

class HomeMayoristaState extends Equatable {
  final List<MayoristaModel>? list;
  final List<MayoristaModel>? listTemp;
  late bool loading;
  late bool isFilter;

  HomeMayoristaState(
      {this.isFilter = false, this.loading = false, this.list, this.listTemp});

  @override
  List<Object?> get props => [isFilter, loading, list, listTemp];
  HomeMayoristaState copyWith({
    List<MayoristaModel>? list,
    List<MayoristaModel>? listTemp,
    bool? loading,
    bool? isFilter,
  }) =>
      HomeMayoristaState(
          loading: loading ?? this.loading,
          isFilter: isFilter ?? this.isFilter,
          list: list ?? this.list,
          listTemp: listTemp ?? this.listTemp);
}
