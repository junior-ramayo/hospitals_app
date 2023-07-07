part of 'login_bloc.dart';

enum LoginButtonState {initial, loading, loaded, error}

class LoginState extends Equatable {

  final String jwt;
  final String errorMessage;
  final bool obscurePassword;
  final LoginButtonState buttonState;
  
  const LoginState({
   this.jwt = '',
   this.errorMessage = '',
   this.obscurePassword = true,
   this.buttonState = LoginButtonState.initial
  });

  LoginState copyWith({
   String? jwt,
   String? errorMessage,
   bool? obscurePassword,
   LoginButtonState? buttonState
  }) => LoginState(
   jwt: jwt ?? this.jwt,
   errorMessage: errorMessage ?? this.errorMessage,
   obscurePassword: obscurePassword ?? this.obscurePassword,
   buttonState: buttonState ?? this.buttonState
  );

  @override
  List<Object?> get props => [
   jwt,
   errorMessage,
   buttonState,
   obscurePassword
  ];
  
}