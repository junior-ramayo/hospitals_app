import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomInput extends StatelessWidget {

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool obscureText;
  final String? hintText;
  final int maxLines;
  final IconData? suffixIcon;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTapIcon;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  
  const CustomInput({
   Key? key,
   required this.controller,
   required this.keyboardType,
   this.maxLength,
   this.maxLines = 1,
   this.hintText,
   this.margin = const EdgeInsets.all(15),
   this.obscureText = false,
   this.validator,
   this.suffixIcon,
   this.width,
   this.height,
   this.inputFormatters,
   this.onTapIcon,
   this.onChanged,
   this.focusNode,
   this.onEditingComplete
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
   return Container(
    width: width,
    height: height,
    margin: margin,
    decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(30),
     boxShadow: [
      BoxShadow(
       color: Colors.grey.withOpacity(0.25),
       blurRadius: 9.0,
       spreadRadius: 2.0,
       offset: const Offset(0, 5.0),
      )
     ]
    ),
    child: TextFormField(
     maxLength: maxLength,
     maxLines: maxLines,
     controller: controller,
     keyboardType: keyboardType,
     obscureText: obscureText,
     inputFormatters: inputFormatters,
     validator: validator,
     onChanged: onChanged,
     focusNode: focusNode,
     onEditingComplete: onEditingComplete,
     decoration: InputDecoration(
      hintText: hintText,
      suffixIcon: GestureDetector(
       onTap: onTapIcon,
        child: Icon(
         suffixIcon,
        ),
      )
     ),
    ),
   );
  }
 }