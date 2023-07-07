import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hospitals_app/src/core/errors/failures.dart';

import '../../../domain/usecases/splash/splash_usecases.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  final SplashUseCases useCases;
  
  SplashBloc({required this.useCases}) : super(const SplashState()) {

   // Este evento se llama cuando la animación del SplashView termina.
   on<CheckLoginEvent>((event, emit) async {
    try{

      final resp = await useCases.checkLoginCase(key: 'token');
      resp.fold(
       (failure){
        emit(state.copyWith(stateLogin: StateLogin.errorLogin));
       },
       (token){
        /*
         Si el token es igual a null, actualizamos el stateLogin a notLoggedIn, 
         lo que quiere decir que no hay inicio de sesión activo y, por lo tanto, 
         podemos llevar al usuario a la pantalla LoginView.
        */
        if(token == null) return emit(state.copyWith(stateLogin: StateLogin.notLoggedIn));

        /* 
        
        Si el token es diferente de null, quiere decir que hay un 
        inicio de sesión activo y, por lo tanto, podemos mandar al
        usuario a la pantalla HomeView.
        */
        emit(state.copyWith(token: token, stateLogin: StateLogin.loggedIn));
       }
      );
   
    } on CacheFailure catch(_){
     emit(state.copyWith(stateLogin: StateLogin.errorLogin));
    }
   });

  }

}
