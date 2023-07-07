part of 'map_bloc.dart';

class MapState extends Equatable {

  final String messageError;
  final bool online;

  const MapState({
   this.online = false,
   this.messageError = ""
  });
  
  MapState copyWith({
   String? messageError,
   bool? online
  }) => MapState(
   online: online ?? this.online,
   messageError: messageError ?? this.messageError
  );

  @override
  List<Object?> get props => [
   online,
   messageError
  ];
}