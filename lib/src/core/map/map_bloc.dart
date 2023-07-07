import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hospitals_app/src/core/network/network_info.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final NetworkInfo netWorkInfo;

  MapBloc({required this.netWorkInfo}) : super(const MapState()) {
    
   on<CheckOnlineEvent>((event, emit) async {
    final resp = await netWorkInfo.isConnected;
    emit(state.copyWith(online: resp));
   });

  }
}
