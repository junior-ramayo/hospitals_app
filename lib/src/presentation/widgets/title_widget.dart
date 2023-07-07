import 'package:flutter/material.dart';

import '../../core/styles/custom_text_style.dart';

class TitleWidget extends StatelessWidget {

  final String label;
  final double fontSize;
  final FontWeight fontWeight;
   
  const TitleWidget({
    super.key, 
    required this.label, 
    this.fontSize = 19,
    this.fontWeight = FontWeight.w900
  });
  
  @override
  Widget build(BuildContext context) {
   return Text(
    label,
    maxLines: 2,
    style: TextStyle(
     fontWeight: fontWeight,
     overflow: TextOverflow.ellipsis,
     fontSize: fontSize,
     fontFamily: CustomTextStyle.mainText
    )
   );
  }
 }