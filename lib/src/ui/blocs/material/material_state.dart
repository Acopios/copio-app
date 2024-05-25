part of 'material_cubit.dart';

sealed class MaterialState extends Equatable {
  const MaterialState();

  @override
  List<Object> get props => [];
}

final class MaterialInitial extends MaterialState {}
