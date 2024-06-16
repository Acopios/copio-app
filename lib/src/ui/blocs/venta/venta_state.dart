part of 'venta_cubit.dart';

 class VentaState extends Equatable {
   final List<MaterialCustom>? materiales;

  const VentaState({this.materiales});

  @override
  List<Object?> get props => [materiales];

  VentaState copyWith({List<MaterialCustom>? materiales}) =>
      VentaState(materiales: materiales ?? this.materiales);
}

