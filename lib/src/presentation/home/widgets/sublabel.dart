import 'package:flutter/material.dart';

import '../../../core/styles/custom_text_style.dart';

class SubLabelWidget extends StatelessWidget {
  
  final String label;
  final EdgeInsetsGeometry? margin;
  final IconData? icon;
  final double? fontSize;

   const SubLabelWidget({
    super.key, 
    this.margin,
    this.icon,
    required this.label,
    this.fontSize
   });
 
   @override
   Widget build(BuildContext context) {
    return Container(
     margin: margin,
     child: Row(
      children: [
       Padding(
        padding: const EdgeInsets.only(right: 6.0),
        child: Icon(icon, color: Colors.grey[400]),
       ),
       Expanded(
        child: Text(
         label,
         maxLines: 2,
         style: TextStyle(
          fontSize: fontSize,
          color: Colors.grey[400],
          overflow: TextOverflow.ellipsis,
          fontFamily: CustomTextStyle.bodyText
         )
        ),
       )
      ],
     ),
    );
   }
 }