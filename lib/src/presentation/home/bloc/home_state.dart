part of 'home_bloc.dart';

enum StateGetData {initial, loading, loaded, error}
enum StateButtonAppointment {initial, loading, loaded, error}

class HomeState extends Equatable {
  
  final int page;
  final String? token;
  final double? latUser;
  final double? longUser;
  final String? codeState;
  final String messageError;
  final String messageResponse;
  final StateGetData getDataState;
  final DataHospitals? dataHospitals;
  final StateButtonAppointment buttonState;

  const HomeState({
   this.token,
   this.latUser,
   this.longUser,
   this.page = 1,
   this.codeState,
   this.dataHospitals,
   this.messageError = "",
   this.messageResponse = "",
   this.getDataState = StateGetData.initial,
   this.buttonState = StateButtonAppointment.initial
  });
  
  HomeState copyWith({
   int? page,
   String? token,
   double? latUser,
   double? longUser,
   String? codeState,
   String? messageError,
   String? messageResponse,
   StateGetData? getDataState,
   DataHospitals? dataHospitals,
   StateButtonAppointment? buttonState
  }) => HomeState(
   page: page ?? this.page,
   token: token ?? this.token,
   latUser: latUser ?? this.latUser,
   longUser: longUser ?? this.longUser,
   codeState: codeState ?? this.codeState,
   buttonState: buttonState ?? this.buttonState,
   messageError: messageError ?? this.messageError,
   getDataState: getDataState ?? this.getDataState,
   dataHospitals: dataHospitals ?? this.dataHospitals,
   messageResponse: messageResponse ?? this.messageResponse
  );

  @override
  List<Object?> get props => [
    page,
    token,
    latUser,
    longUser,
    codeState,
    buttonState,
    messageError,
    getDataState,
    dataHospitals,
    messageResponse,
  ];
}