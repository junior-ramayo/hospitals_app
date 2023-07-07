import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hospitals_app/src/core/errors/failures.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/register/register_use_cases.dart';
part 'register_event.dart';
part 'register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {


  final RegisterUseCases useCases;
  final GlobalKey keyPasswordController = GlobalKey();
  final GlobalKey keyNameController = GlobalKey();
  final GlobalKey keyCellPhoneController = GlobalKey();
  final FocusNode focusName = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPhoneNumber = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cellPhoneController = TextEditingController();

  RegisterBloc({required this.useCases}) : super(const RegisterState()) {
    
    /* 
     Este evento se llama cuando presionamos el botón `crear cuenta` en el RegisterView
    */
    on<CreateUserEvent>((event, emit) async {
     try{
      // Se crea un objeto User con los datos ingresados en los controladores.
      final user = User(
       userName: emailController.text,
       cellPhone: cellPhoneController.text,
       name: nameController.text,
       password: passwordController.text
      );
      // Se llama al caso de uso createUserCase para crear el usuario.
      final resp = await useCases.createUserCase(user: user);

      /* 
      Si hay un Failure (fracaso), se emite un nuevo estado con el mensaje de error obtenido del Failure.
      */
      resp.fold(
       (failure) {
        emit(state.copyWith(errorMessage: failure.message));
       }, 
       (userResponse) {
        /* 
         Si la respuesta es exitosa, se emite un nuevo estado con errorMessage vacío, 
         userResponse establecido como la respuesta del usuario y messageUI establecido 
         en "Ahora puedes hacer login con tu cuenta".
        */
        emit(
         state.copyWith(
          errorMessage: '',
          userResponse: userResponse,
          messageUI: "Ahora puedes hacer login con tu cuenta"
         )
        );
       }
      );
     }on Failure catch(err){
      emit(state.copyWith(errorMessage: err.message));
     }
    });
    // Evento para cambiar el obscureText del inputPassword
    on<WatchPasswordEvent>((event, emit) async {
     final newValue = !state.obscurePassword;
     emit(state.copyWith(obscurePassword: newValue));
    });
  
  }

  /* 
   Este método jump se utiliza para realizar un salto o desplazamiento suave en un ScrollController 
   hasta un widget identificado por su GlobalKey.
  */
  void jump({required GlobalKey<State<StatefulWidget>> widgetKey}){
   RenderObject? renderObject = widgetKey.currentContext!.findRenderObject();
   double offset = renderObject!.semanticBounds.bottom;
   scrollController.animateTo(
    offset,
    duration: const Duration(milliseconds: 700),
    curve: Curves.easeInOut,
   );
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
   passwordController.dispose();
   nameController.dispose();
   cellPhoneController.dispose();
   focusEmail.dispose();
   focusPhoneNumber.dispose();
   focusName.dispose();
   focusPassword.dispose();
   scrollController.dispose();
   return super.close();
  }
}
