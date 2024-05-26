part of 'compra_cubit.dart';

class CompraState extends Equatable {
  final List<MaterialCustom>? materiales;

  const CompraState({this.materiales});

  @override
  List<Object?> get props => [materiales];

  CompraState copyWith({List<MaterialCustom>? materiales}) =>
      CompraState(materiales: materiales ?? this.materiales);
}
