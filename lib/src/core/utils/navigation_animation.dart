import 'package:flutter/material.dart';


 class SlideAnimationRoute extends PageRouteBuilder { 

  final Widget page;
  final Offset begin;
  final Offset end;

  SlideAnimationRoute({
   required this.page,
   this.begin = const Offset(1.0, 0.0),
   this.end = const Offset(0.0, 0.0)
  }) : super(
   pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
   transitionDuration: (const Duration(milliseconds: 2000)),
   transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
     position: Tween<Offset>(
      begin: begin,
      end: end
     ).animate(
      CurvedAnimation(
       parent: animation,
       curve: Curves.fastOutSlowIn
      )
     ),
     child: page,
    );
   },
  );
 }