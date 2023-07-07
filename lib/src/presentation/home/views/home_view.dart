import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../../core/gps/gps_bloc.dart';
import '../widgets/gps_widget.dart';
import '../widgets/home_body.dart';



class HomeView extends StatelessWidget {

 const HomeView({super.key});

 @override
 Widget build(BuildContext context) {
  final args = ModalRoute.of(context)!.settings.arguments as Map;
  return BlocProvider<GpsBloc>(
   create: (context) => sl<GpsBloc>(),
   child: Scaffold(
    body: BlocBuilder<GpsBloc, GpsState>(
     builder: (context, gpsState) {
      /* 
       Si los datos de posición del gpsState están vacíos, 
       mostramos el widget GPSWidget para solicitar los permisos de ubicación
      */
      return gpsState.dataPosition.isEmpty
      ? const GpsWidget()
      /* 
       Una vez obtenida la ubicación, mostramos el homeBody
      */
      : HomeBody(dataPosition: gpsState.dataPosition, jwt: args["jwt"]);
     }
    )
   ),
  );
 }
}