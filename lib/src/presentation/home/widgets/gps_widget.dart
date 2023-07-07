import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/gps/gps_bloc.dart';
import '../../../core/styles/custom_text_style.dart';
import '../../widgets/custom_button.dart';

class GpsWidget extends StatelessWidget {
 const GpsWidget({super.key});

 @override
 Widget build(BuildContext context) {
  final gpsBloc = BlocProvider.of<GpsBloc>(context);
  return BlocBuilder<GpsBloc, GpsState>(
   builder: (context, gpsState) {
    return LayoutBuilder(
     builder: (context, constrains) {
      return gpsState.stateGps == GetUbicationState.loading
      ? const Center(child: CircularProgressIndicator())
      : !gpsState.isGpsEnabled
      ? const Center(
       child: Text(
        'Activa el GPS del celular, por favor',
        style: TextStyle(
         fontFamily: CustomTextStyle.bodyText
        ),
       )
      )
      : SafeArea(
       child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: constrains.maxHeight * 0.035),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           SizedBox(
            child: Image.asset(
             'assets/images/gps_image.png',
             width: double.infinity,
             height: constrains.maxHeight * 0.55,
             fit: BoxFit.cover,
            ),
           ),
           Padding(
            padding: EdgeInsets.only(
             top: constrains.maxHeight * 0.017,
             bottom: constrains.maxHeight * 0.018
            ),
            child: Text(
             'Activa tu ubicación',
             style: TextStyle(
              fontFamily: CustomTextStyle.mainText,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold,
              fontSize: constrains.maxWidth * 0.055
             ),
            ),
           ),
          Container(
           width: constrains.maxWidth * 0.70,
           margin: EdgeInsets.only(
            top: constrains.maxHeight * 0.011,
            left: 25, 
            right: 25
           ),
           child: Text(
            'Para empezar a usar la app debes activar tu ubicación',
            textAlign: TextAlign.center,
            style: TextStyle(
             color: Colors.grey,
             height: 0.95,
             fontFamily: CustomTextStyle.bodyText,
             fontSize: constrains.maxWidth * 0.055
            ),
           ),
          ),
          const Spacer(),
          CustomButton(
           label: 'Obtener posición',
           margin: EdgeInsets.all(constrains.maxWidth * 0.06),
           onPressed: (){
            gpsBloc.add(GetPositionEvent());
           }
          ),
         ],
        ),
       ),
      );
     }
    );
   }
  );
 }
}