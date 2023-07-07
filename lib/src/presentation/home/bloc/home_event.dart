part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAllHospitalsEvent extends HomeEvent {
  final String token;
  final double lat;
  final double long;
  final String codeState;
  final int page;

  const GetAllHospitalsEvent({
   required this.token,
   required this.lat,
   required this.long,
   required this.page,
   required this.codeState,
  });
  
}

class CreateAnAppointmentEvent extends HomeEvent {
 
 final String hospitalId;
 final String token;

 const CreateAnAppointmentEvent({
  required this.hospitalId,
  required this.token
 });

}