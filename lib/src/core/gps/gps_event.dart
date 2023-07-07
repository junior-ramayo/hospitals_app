part of 'gps_bloc.dart';


abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class CheckGpsEvent extends GpsEvent {}


class GpsAndPermissionEvent extends GpsEvent {
  
  final bool isGpsEnabled;

  const GpsAndPermissionEvent({
    required this.isGpsEnabled
  });
}

class GetPositionEvent extends GpsEvent {}
