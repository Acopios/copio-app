part of 'login_cubit.dart';

class LoginState implements Equatable {
  final bool enabled;
  final bool visible;
  LoginState({
    this.enabled = false,
    this.visible = true,
  });
  LoginState copyWith({bool? enabled, bool? visible}) =>
      LoginState(enabled: enabled ?? this.enabled, visible: visible ?? this.visible);
  @override
  List<Object?> get props => [enabled, visible];

  @override
  bool? get stringify => false;
}
