part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<RecolectorModel>? listRecolectores;
  final List<RecolectorModel>? listRecolectoresTemp;
  late bool loading;
  late bool isFilter;
  HomeState(
      {this.listRecolectores,
      this.listRecolectoresTemp,
      this.loading = false,
      this.isFilter = false});

  @override
  List<Object?> get props => [listRecolectores, loading, listRecolectoresTemp, isFilter];

  HomeState copyWith(
          {List<RecolectorModel>? listRecolectores,
          bool? loading,
          bool? isFilter,
          List<RecolectorModel>? listRecolectoresTemp}) =>
      HomeState(
        isFilter:  isFilter ?? this.isFilter,
          listRecolectoresTemp:
              listRecolectoresTemp ?? this.listRecolectoresTemp,
          listRecolectores: listRecolectores ?? this.listRecolectores,
          loading: loading ?? this.loading);
}
