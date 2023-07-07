part of 'splash_bloc.dart';

enum StateLogin {initial, notLoggedIn, loggedIn, errorLogin}

class SplashState extends Equatable {

  
  final String? token;
  final StateLogin stateLogin;
  
  const SplashState({
   this.token,
   this.stateLogin = StateLogin.initial
  });

  SplashState copyWith({
   String? token,
   StateLogin? stateLogin
  }) => SplashState(
   token: token ?? this.token,
   stateLogin: stateLogin ?? this.stateLogin
  );
  
  @override
  List<Object?> get props => [
   token,
   stateLogin
  ];
}