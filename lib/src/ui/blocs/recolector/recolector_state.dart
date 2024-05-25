part of 'recolector_cubit.dart';

class RecolectorState extends Equatable {
  late bool enabled;
  late bool loading;
  RecolectorState({this.enabled = false, this.loading = false});

  @override
  List<Object> get props => [enabled, loading];

  RecolectorState copyWith({bool? enabled, bool? loading}) => RecolectorState(
      enabled: enabled ?? this.enabled, loading: loading ?? this.loading);
}
