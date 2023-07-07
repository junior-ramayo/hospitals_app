import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../utils/codes_states.dart';


part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSuscription;
  

  GpsBloc() : super(const GpsState(isGpsEnabled: false)) {

   on<CheckGpsEvent>(_checkGps);
    
   on<GpsAndPermissionEvent>((event, emit) {
    emit(state.copyWith(
     isGpsEnabled: event.isGpsEnabled
    ));
   });
   
   on<GetPositionEvent>((event, emit) async{
    try{
     LocationPermission permissions;
    
     /* 
     Se llama a Geolocator.checkPermission para verificar el estado 
     de los permisos de ubicación. El resultado se asigna a la variable permissions.
     */
     permissions = await Geolocator.checkPermission();
     if (permissions == LocationPermission.denied) {
      /* 
      Si los permisos están denegados (LocationPermission.denied), 
      se llama a Geolocator.requestPermission para solicitar permisos al usuario
      */
      permissions = await Geolocator.requestPermission();
      if (permissions == LocationPermission.denied) {
       return emit(state.copyWith(stateGps: GetUbicationState.pause));
      }
     }
  
     /* 
     Si los permisos están denegados permanentemente (LocationPermission.deniedForever), 
     se llama a openAppSettings para abrir la configuración de la aplicación y permitir 
     que el usuario modifique los permisos.
     */
     if (permissions == LocationPermission.deniedForever) {
       openAppSettings();
       return emit(state.copyWith(stateGps: GetUbicationState.pause));
     }
  
     // Obtener la posición actual del usuario
     Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
     );
  
     /* 
     Se llama a placemarkFromCoordinates para obtener información de ubicación 
     basada en las coordenadas de latitud y longitud. El resultado se asigna a la 
     variable address, que es una lista de objetos Placemark.
     */
     List<Placemark>? address = await placemarkFromCoordinates(position.latitude, position.longitude);

     /* 
     Se obtiene el código de estado (state code) utilizando el método getCodeState de la clase CodeState, 
     pasando el área administrativa (administrativeArea) del primer objeto Placemark.
     */
     final String codeState = CodeState.getCodeState(administrativeArea: address[0].administrativeArea!);
     
     /* 
     Se emite un nuevo estado con state.copyWith que incluye los datos 
     de posición (latitud, longitud y código de estado) y se establece 
     el estado de obtención de la ubicación como exitoso (GetUbicationState.successful):
     */
     emit(
      state.copyWith(
       dataPosition: {
        "latitud": position.latitude,
        "longitud": position.longitude,
        "codeState": codeState
       },
       stateGps: GetUbicationState.successful
      )
     );
     /*
      Se cancela la suscripción gpsServiceSuscription.
     */
     gpsServiceSuscription?.cancel();
    } on Exception catch(_){
     emit(state.copyWith(stateGps: GetUbicationState.error));
    }
   });

   add(CheckGpsEvent());
  
  }

  Future<void> _checkGps(CheckGpsEvent event, Emitter<GpsState> emit) async {

   emit(state.copyWith(stateGps: GetUbicationState.loading));
   /*
    Se llama a Geolocator.isLocationServiceEnabled para verificar si 
    el servicio de ubicación está habilitado. El resultado se asigna a la variable isEnabled.
    */
   bool isEnabled = await Geolocator.isLocationServiceEnabled();
   add(GpsAndPermissionEvent(isGpsEnabled: isEnabled));

   /* 
   Si el GPS está habilitado (isEnabled es true), 
   se agrega un evento GetPositionEvent para obtener la posición actual
   */
   if(isEnabled) {
    add(GetPositionEvent());
   } else {
    /* 
     Si el GPS no está habilitado (isEnabled es false), se emite un 
     nuevo estado con state.copyWith para indicar que la obtención de la ubicación está en pausa
    */
    emit(state.copyWith(stateGps: GetUbicationState.pause));
   }

   /* 
    Se crea una suscripción a Geolocator.getServiceStatusStream() para recibir 
    actualizaciones del estado del servicio de ubicación. La suscripción utiliza 
    el método listen y pasa una función de devolución de llamada que se ejecuta 
    cada vez que se recibe un evento.
   */
   gpsServiceSuscription = Geolocator.getServiceStatusStream().listen((event) async {
    final isEnabled = (event.index == 1) ? true : false;
    add(GpsAndPermissionEvent(
     isGpsEnabled: isEnabled,
    ));

    if(isEnabled) {
      add(GetPositionEvent());
    } else {
     emit(state.copyWith(stateGps: GetUbicationState.pause));
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
    gpsServiceSuscription?.cancel();
    return super.close();
  }

}