import 'package:flutter/material.dart';

import 'custom_text_style.dart';



class ThemeCustomData {
 static ThemeData themeData(){
  return ThemeData(
   iconTheme: const IconThemeData(
    color: Colors.white
   ),
   textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
     textStyle: MaterialStatePropertyAll(TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 15
     ))
    )
   ),
   elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
     backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
       if (states.contains(MaterialState.disabled)) {
        return Colors.grey;
       }
       return const Color(0xff37BEF3);
      },
     ),
     shape: const MaterialStatePropertyAll(
      RoundedRectangleBorder(
       borderRadius: BorderRadius.all(Radius.circular(11))
      )
     ),
     minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 40)),
     elevation: const MaterialStatePropertyAll(8)
    )
   ),
   inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
     borderRadius: BorderRadius.circular(30.0),
     borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
     borderRadius:BorderRadius.circular(30),
     borderSide: const BorderSide(color: Colors.white, width: 1.0)
    ),
    contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    suffixIconColor: const Color(0xff37BEF3),
    hintStyle: const TextStyle(
     color: Colors.grey,
     fontWeight: FontWeight.bold,
     fontFamily: CustomTextStyle.bodyText
    )
   )
  );
 }
}