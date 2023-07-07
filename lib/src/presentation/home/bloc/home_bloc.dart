import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hospitals_app/src/domain/usecases/home/home_usecases.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/hospital.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  final HomeUseCases useCases;
  final ScrollController scrollController = ScrollController();

  HomeBloc({required this.useCases}) : super(const HomeState()) {
    
   /* 
    Este evento es llamado por primera vez cuando se crea el BlocProvider<HomeBloc>
   */
   on<GetAllHospitalsEvent>((event, emit) async {
    try{
     /* 
     Se verifica si state.page es igual a 1 para determinar si es la 
     primera vez que se solicitan los hospitales.
     */
     if(state.page == 1){
      emit(state.copyWith(
       latUser: event.lat,
       longUser: event.long,
       codeState: event.codeState,
       page: event.page,
       token: event.token
      ));
      emit(state.copyWith(getDataState: StateGetData.loading));
     }
     final resp = await useCases.getAllHospitalsCase(
      token: event.token,
      lat: event.lat,
      long: event.long,
      codeState: event.codeState,
      page: event.page
     );
     resp.fold(
      (failure) {
       emit(state.copyWith(messageError: failure.message, getDataState: StateGetData.error));
      },
      (data) {
       /* 
       Si obtenemos una respuesta exitosa aumentamos en una el page para la siguiente llamada
       */
       int newPage = state.page;
       newPage++;
       /* 
       Si el state.page es diferente de 1, quiere decir que volvimos a llamar a este evento 
       para traer los demás hospitales, así que colocamos los hospitales anteriores al 
       inicio de los nuevos hospitales
       */
       if(state.page != 1){
        data.hospitals.insertAll(0, state.dataHospitals!.hospitals);
       }
       /* 
       Se emite un nuevo estado con los datos actualizados y el estado de carga completada
       */
       emit(
        state.copyWith(
         page: newPage,
         messageError: "",
         dataHospitals: data,
         getDataState: StateGetData.loaded
        )
       );
       _scrollInit();
      }
     );

    } on Failure catch(err){
     emit(state.copyWith(messageError: err.message, getDataState: StateGetData.error));
    }
   });

   /* 
   Este evento se llama cuando se presiona el botón "Agendar cita" que está en la pantalla DetailsView
   */
   on<CreateAnAppointmentEvent>((event, emit) async {
    try{
     //Se emite un nuevo estado para indicar que se está realizando la creación de una cita.
     emit(
      state.copyWith(
       messageError: "",
       buttonState: StateButtonAppointment.loading
      )
     );
     final resp = await useCases.createAnAppointmentCase(hospitalId: event.hospitalId, token: event.token);
     
     /* 
     Si hay un Failure (fracaso), se emite un nuevo estado con un mensaje de error obtenido del Failure 
     y buttonState establecido en StateButtonAppointment.error.
     */
     resp.fold(
      (failure){
       emit(
        state.copyWith(
         messageError: failure.message, 
         buttonState: StateButtonAppointment.error
        )
       );
      },
      (response){
       /* 
        Si la respuesta es exitosa, se emite un nuevo estado con messageError vacío y buttonState 
        establecido en StateButtonAppointment.loaded para indicar que la creación de la cita 
        se completó correctamente.
       */
       emit(
        state.copyWith(
         messageError: "",
         buttonState: StateButtonAppointment.loaded
        )
       );
      }
     );
    }on Failure catch(err){
     emit(
      state.copyWith(
       messageError: err.message,
       buttonState: StateButtonAppointment.error
      )
     );
    }
   });


  }


  void _scrollInit(){
   /* 
   Se verifica si state.page es mayor que el número total de páginas de datos disponibles.
   Si state.page es mayor, significa que se han cargado todos los datos disponibles y 
   no es necesario seguir escuchando eventos de desplazamiento. En este caso, se libera el 
   controlador de desplazamiento con scrollController.dispose() y se retorna para salir del método.
   */
   if(state.page > state.dataHospitals!.totalPages) {
    scrollController.dispose();
    return;
   }
   /* 
   El listener se activa cada vez que se desplaza la lista. Se verifica si la posición actual 
   (scrollController.position.pixels) es igual a la posición máxima de desplazamiento 
   (scrollController.position.maxScrollExtent), lo que indica que se ha alcanzado el final de la lista.

   Cuando se detecta el final de la lista, se vuelve a llamar al evento GetAllHospitalsEvent
    para cargar más datos.
   */
   scrollController.addListener(() {
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
     add(
      GetAllHospitalsEvent(
       codeState: state.codeState!, 
       lat: state.latUser!, 
       long: state.longUser!,
       page: state.page,
       token: state.token!
      )
     );
    }
   });
  }

  /* 
   Este método close se sobrescribe de la clase base y se utiliza para realizar 
   las tareas de limpieza y liberación de recursos al cerrar el BLoC.
 
   Este código se ejecuta de manera automática cuando el BLoC se cierra, por lo tanto, 
   no hay que llamarlo en un dispose de un StatefulWidget
  */
  @override
  Future<void> close() {
   scrollController.dispose();
   return super.close();
  }
}