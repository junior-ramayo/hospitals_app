import 'package:flutter/material.dart';

import '../../core/styles/custom_text_style.dart';

 class CustomButton extends StatelessWidget {

  final String label;
  final void Function()? onPressed;
  final double? fontSize;
  final Size? minimumSize;
  final EdgeInsetsGeometry? margin;
   
  const CustomButton({
    super.key,
    required this.label,
    this.fontSize,
    required this.onPressed,
    this.minimumSize,
    this.margin
  });
 
  @override
  Widget build(BuildContext context) {
   return Container(
    margin: margin,
    child: ElevatedButton(
     style: ElevatedButton.styleFrom(
      minimumSize: minimumSize
     ),
     onPressed: onPressed,
     child: Text(
      label,
      style: TextStyle(
       fontSize: fontSize,
       fontWeight: FontWeight.w700,
       fontFamily: CustomTextStyle.bodyText
      ),
     )
    ),
   );
  }
 }