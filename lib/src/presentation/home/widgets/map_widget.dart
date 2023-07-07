import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitals_app/src/core/network/network_info.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../../injection_container.dart';
import '../../../core/colors/colors_app.dart';
import '../../../core/map/map_bloc.dart';


 class MapWidget extends StatelessWidget {

  final double latitud;
  final double longitud;
   
  const MapWidget({
   super.key,
   required this.latitud,
   required this.longitud
  });
  
  @override
  Widget build(BuildContext context) {
   return BlocProvider<MapBloc>(
    create: (context) => MapBloc(netWorkInfo: sl<NetworkInfo>())..add(CheckOnlineEvent()),
    child: Container(
     height: 210,
     margin: const EdgeInsets.symmetric(
      vertical: 15
     ),
     decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15))
     ),
     child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: BlocBuilder<MapBloc, MapState>(
       builder: (context, state){
        return !state.online
        ? const Image(
         fit: BoxFit.cover,
         image: AssetImage(
          "assets/images/no-image.jpg"
         )
        )
        : FlutterMap(
         options: MapOptions(
          center: LatLng(latitud,longitud),
          zoom: 17.0,
          maxZoom: 18.0
         ),
         nonRotatedChildren: [
          MarkerLayer(
           markers: [
            Marker(
             point: LatLng(latitud,longitud),
             builder: (context) => Icon(
              Icons.location_on,
              color: ColorsApp.colorBlueApp,
              size: 40,
             ),
            ),
           ],
          )
         ],
         children: [
          TileLayer(
           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
           userAgentPackageName: 'com.example.app',
           tileProvider: NetworkTileProvider(),
          ),
         ],
        );
       },
      ),
     ),
    ),
   );
  }
 }