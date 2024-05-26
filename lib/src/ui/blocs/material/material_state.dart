// ignore_for_file: must_be_immutable

part of 'material_cubit.dart';

class MaterialState extends Equatable {
  late bool loading;
  MaterialState({
    this.loading = false,
  });

  @override
  List<Object> get props => [loading];
  MaterialState copyWith({bool? loading}) =>
      MaterialState(loading: loading ?? this.loading);
}
