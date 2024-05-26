part of 'register_cubit.dart';

class RegisterState implements Equatable {
  late bool enabled;
  late bool loading;
  RegisterState({
    this.enabled = false,
    this.loading = false,
  });
  @override
  List<Object?> get props => [enabled, loading];

  @override
  bool? get stringify => false;
  RegisterState copyWith({bool? enabled, bool? loading}) => RegisterState(
      enabled: enabled ?? this.enabled, loading: loading ?? this.loading);
}
