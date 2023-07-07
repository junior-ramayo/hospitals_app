import 'package:flutter/material.dart';

import '../../../core/colors/colors_app.dart';
import '../../../core/styles/custom_text_style.dart';

class CustomHeaderHome extends StatelessWidget {
  
  const CustomHeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
   return LayoutBuilder(
    builder: (context, constrains){
     return Container(
      padding: EdgeInsets.all(constrains.maxWidth * 0.06),
      child: Column(
       children: [
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
          Text(
           'Hola!',
           style: TextStyle(
            fontSize: constrains.maxWidth * 0.09,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            fontFamily: CustomTextStyle.mainText
           ),
          ),
          Row(
           children: [
            CircleAvatar(
             backgroundColor: Colors.blue.withOpacity(0.1),
             radius: constrains.maxWidth * 0.06,
             child: Icon(
              Icons.notifications,
              color: ColorsApp.colorBlueApp,
             ),
            ),
            SizedBox(width: constrains.maxWidth * 0.04),
            CircleAvatar(
             radius: constrains.maxWidth * 0.06,
             child: const Icon(Icons.person),
            ),
           ],
          )
         ],
        ),
        Container(
         margin: EdgeInsets.only(top: constrains.maxWidth * 0.06),
         decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
           BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 9.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 5.0),
           )
          ]
         ),
         padding: EdgeInsets.all(constrains.maxWidth * 0.04),
         child: LayoutBuilder(
          builder: (context, size) {
           return Row(
            children: [
             Icon(
              Icons.search,
              color: Colors.grey[400],
             ),
             SizedBox(width: size.maxWidth * 0.04),
             Expanded(
               child: Text(
                'Encuentra una especialidad cerca de ti',
                maxLines: 1,
                style: TextStyle(
                 color: Colors.grey[400],
                 fontWeight: FontWeight.w400,
                 fontSize: size.maxWidth * 0.045,
                 overflow: TextOverflow.ellipsis,
                 fontFamily: CustomTextStyle.bodyText
                ),
               ),
             )
            ],
           );
          }
         ),
        )
       ],
      ),
     );
    },
   );
  }
}