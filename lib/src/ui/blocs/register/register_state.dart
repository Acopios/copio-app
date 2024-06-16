// ignore_for_file: must_be_immutable

part of 'register_cubit.dart';

class RegisterState implements Equatable {
  late bool enabled;
  late bool loading;
  late bool visible;
  RegisterState({
    this.enabled = false,
    this.loading = false,
    this.visible = true,
  });
  @override
  List<Object?> get props => [enabled, loading, visible];

  @override
  bool? get stringify => false;
  RegisterState copyWith({bool? enabled, bool? loading, bool? visible}) => RegisterState(
      enabled: enabled ?? this.enabled, loading: loading ?? this.loading, visible: visible ?? this.visible);
}
