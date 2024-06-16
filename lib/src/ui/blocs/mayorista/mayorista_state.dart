part of 'mayorista_cubit.dart';

class MayoristaState extends Equatable {
  late bool loading;
  late bool enabled;

  MayoristaState({this.loading = false, this.enabled = false});

  @override
  List<Object?> get props => [loading, enabled];

  MayoristaState copyWith({bool? loading, bool? enabled}) => MayoristaState(
      loading: loading ?? this.loading, enabled: enabled ?? this.enabled);
}
