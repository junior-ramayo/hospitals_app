import 'package:flutter/material.dart';

import '../../../domain/entities/hospital.dart';
import '../../widgets/title_widget.dart';
import 'image_widget.dart';
import 'sublabel.dart';


 class HospitalItemWidget extends StatelessWidget {

  final BoxConstraints constraints;
  final void Function()? onTap;
  final Hospital hospital;
  
  const HospitalItemWidget({
   super.key, 
   required this.constraints,
   this.onTap,
   required this.hospital
  });

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
    onTap: onTap,
    child: Container(
     height: constraints.maxHeight * 0.25,
     decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(19)),
      boxShadow: [
       BoxShadow(
        color: Colors.grey.withOpacity(0.25),
        blurRadius: 9.0,
        spreadRadius: 2.0,
        offset: const Offset(0, 5.0),
       )
      ]
     ),
     margin: EdgeInsets.only(
      bottom: constraints.maxHeight * 0.045
     ),
     child: LayoutBuilder(
      builder: (context, size){
       return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(19)),
        child: Row(
         mainAxisSize: MainAxisSize.min,
         children: [
          ImageWidget(
           width: size.maxWidth * 0.38,
           imageURL: hospital.foto
          ),
          Expanded(
           child: Container(
            padding: EdgeInsets.symmetric(
             vertical: size.maxHeight * 0.10,
             horizontal: size.maxWidth * 0.03
            ),
            child: LayoutBuilder(
             builder: (context, boxConstraints) {
              return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                Expanded(
                 child: TitleWidget(
                  label: hospital.name,
                  fontWeight: FontWeight.w700,
                  fontSize: boxConstraints.maxHeight * 0.135,
                 ),
                ),
                SubLabelWidget(
                 label: hospital.horario,
                 icon: Icons.watch_later_outlined,
                 fontSize: boxConstraints.maxWidth * 0.06,
                 margin: EdgeInsets.only(
                  bottom: boxConstraints.maxHeight * 0.06
                 )
                ),
                SubLabelWidget(
                 label: hospital.direccion,
                 icon: Icons.location_on,
                 fontSize: boxConstraints.maxWidth * 0.06,
                )
               ],
              );
             }
            ),
           ),
          )
         ],
        ),
       );
      }
     ),
    ),
   );
  }
 }