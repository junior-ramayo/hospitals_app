part of 'register_bloc.dart';

class RegisterState extends Equatable {
  
  final String errorMessage;
  final User? userResponse;
  final String messageUI;
  final bool obscurePassword;

  const RegisterState({
   this.errorMessage = '',
   this.messageUI = '',
   this.userResponse,
   this.obscurePassword = true
  });

  RegisterState copyWith({
   String? errorMessage,
   String? messageUI,
   User? userResponse,
   bool? obscurePassword
  }) => RegisterState(
   messageUI: messageUI ?? this.messageUI,
   errorMessage: errorMessage ?? this.errorMessage,
   userResponse: userResponse ?? this.userResponse,
   obscurePassword: obscurePassword ?? this.obscurePassword
  );
  
  @override
  List<Object?> get props => [
   errorMessage,
   userResponse,
   messageUI,
   obscurePassword
  ];
}