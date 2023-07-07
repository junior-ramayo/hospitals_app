import 'package:flutter/material.dart';

import '../../../core/colors/colors_app.dart';

class HeaderRegister extends StatelessWidget {
  
  const HeaderRegister({super.key});

  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
   return Container(
    width: double.infinity,
    height: size.height * 0.41,
    decoration: BoxDecoration(
     gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: ColorsApp.backgroundColor()
     ),
     borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(95)
     )
    ),
    child: SafeArea(
     child: LayoutBuilder(
       builder: (context, constrains) {
         return Stack(
          alignment: Alignment.center,
          children: [
           const Align(
            alignment: Alignment.topLeft,
            child: BackButton()
           ),
           CircleAvatar(
            backgroundColor: Colors.white,
            radius: constrains.maxWidth * 0.13,
            child: LayoutBuilder(
             builder: (context, constrain) {
              return Icon(
               Icons.person,
               size: constrain.maxWidth * 0.70,
              );
             }
            ),
           )
          ],
         );
       }
     ),
    ),
   );
  }
}