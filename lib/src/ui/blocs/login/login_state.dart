part of 'login_cubit.dart';

class LoginState implements Equatable {
  final bool enabled;
  LoginState({
    this.enabled = false,
  });
  LoginState copyWith({bool? enabled}) =>
      LoginState(enabled: enabled ?? this.enabled);
  @override
  List<Object?> get props => [enabled];

  @override
  bool? get stringify => false;
}
