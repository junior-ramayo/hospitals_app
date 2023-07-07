import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hospitals_app/src/core/errors/failures.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/login/login_use_cases.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {


  final LoginUseCases useCases;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  
  LoginBloc({required this.useCases}) : super(const LoginState()) {
    
    // Este evento se llama cuando el usuario presiona el botón `log in` en el LoginView
    on<LoginUserEvent>((event, emit) async {
     try{
     
      emit(state.copyWith(buttonState: LoginButtonState.loading, errorMessage: ''));

      /* 
      Se crea un objeto User a partir de los valores ingresados en los controladores 
      de correo electrónico (emailController) y contraseña (passController).
      */
      User user = User(
       userName: emailController.text,
       password: passController.text,
       name: '',
       cellPhone: ''
      );

      final resp = await useCases.loginUseCase(user: user);

      /* 
       Si la respuesta es un Left que contiene un objeto Failure, se actualiza el estado 
       con el mensaje de error correspondiente y se establece el estado del botón de 
       inicio de sesión como error.
      */
      resp.fold(
       (failure){
        emit(state.copyWith(
          errorMessage: failure.message, 
          buttonState: LoginButtonState.error
         )
        );
       },
       (token){
        /* 
         Si la respuesta es un Right que contiene un valor de tipo String (el token de autenticación), 
         se actualiza el estado con el token y se restablece el mensaje de error, además de establecer 
         el estado del botón de inicio de sesión como cargado.
        */
        emit(
         state.copyWith(
          jwt: token, 
          errorMessage: '',
          buttonState: LoginButtonState.loaded
         )
        );
       }
      );

     }on ServerFailure catch(err){
      emit(state.copyWith(errorMessage: err.message, buttonState: LoginButtonState.error));
     }
    });
    // Evento para cambiar el obscureText del inputPassword
    on<LoginWatchPassEvent>((event, emit) {
     final newValue = !state.obscurePassword;
     emit(state.copyWith(obscurePassword: newValue, errorMessage: ''));
    });

  }

  //Método para cambiar el icono si el usuario activa o desactiva el obscureText para el password
  IconData? suffixIcon({required bool value}){
   return value
   ? Icons.lock_outline
   : Icons.lock_open;
  }

  /* 
  Este método close se sobrescribe de la clase base y se utiliza para realizar 
  las tareas de limpieza y liberación de recursos al cerrar el Bloc.

  Este código se ejecuta de manera automática cuando el BLoC se cierra, por lo tanto, 
  no hay que llamarlo en un dispose de un StatefulWidget
  */
  @override
  Future<void> close() {
   emailController.dispose();
   passController.dispose();
   return super.close();
  }
}
