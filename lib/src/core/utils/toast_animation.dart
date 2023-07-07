import 'package:flutter/material.dart';

import '../styles/custom_text_style.dart';


class Toast extends StatefulWidget {

  final Color color;
  final String message;
  final EdgeInsetsGeometry margin;

  const Toast({
    Key? key, 
    required this.color,
    required this.message,
    required this.margin
  }) : super(key: key);

  @override
  State<Toast> createState() => _ToastState();
}

class _ToastState extends State<Toast> with TickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
   _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
   )..repeat(reverse: true);
   super.initState();
  }

  @override
  void dispose() {
   _controller.dispose();
   super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Align(
    alignment: Alignment.bottomCenter,
    child: FadeTransition(
      opacity: CurvedAnimation(
       parent: _controller,
       curve: Curves.easeOutBack
      ),
      child: Container(
       margin: widget.margin,
       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
       decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(25.0),
       ),
       child: DefaultTextStyle(
         style: const TextStyle(
          color: Colors.white,
          fontFamily: CustomTextStyle.bodyText
         ),
         child: Text(
          widget.message
         ),
       ),
      ),
    ),
   );
  }
}

class MyToast {

 static Future<void> showToast({
  Color color = Colors.red, 
  EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 30), 
  required BuildContext context, 
  required String message, 
  required Duration duration
 }) async {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Toast(
      message: message, 
      margin: margin,
      color: color,
    ),
  );
  overlayState.insert(overlayEntry);
  await Future.delayed(duration);
  overlayEntry.remove();
 }
}