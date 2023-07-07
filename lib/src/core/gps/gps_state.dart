part of 'gps_bloc.dart';

 enum GetUbicationState {initial, loading, successful, pause, error}

 class GpsState extends Equatable {

  final bool isGpsEnabled;
  final GetUbicationState stateGps;
  final Map<String, dynamic> dataPosition;

  const GpsState({
   required this.isGpsEnabled,
   this.dataPosition = const {},
   this.stateGps = GetUbicationState.initial,
  });

  GpsState copyWith({
   bool? isGpsEnabled,
   GetUbicationState? stateGps,
   Map<String, dynamic>? dataPosition
  }) => GpsState(
    isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
    stateGps: stateGps ?? this.stateGps,
    dataPosition: dataPosition ?? this.dataPosition
  );
  
  @override
  List<Object?> get props => [
    isGpsEnabled,
    stateGps,
    dataPosition
  ];
}