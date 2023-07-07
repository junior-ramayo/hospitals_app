import 'package:flutter/material.dart';

class MySnackBar{

  static void show({Color backgroundColor = Colors.red, required BuildContext context, required String label}){
   final snackBar = SnackBar(
    content: Text(
     label,
    ),
    duration: const Duration(seconds: 10),
    backgroundColor: backgroundColor,
   );
   ScaffoldMessenger.of(context).showSnackBar(snackBar);
   return;
  }
   
}