import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospitals_app/src/core/routes/routes.dart';
import 'injection_container.dart' as di;
import 'src/core/styles/theme_custom_data.dart';

Future<void> main() async {

 WidgetsFlutterBinding.ensureInitialized();
 SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown
 ]);
 await di.init();
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {

 const MyApp({super.key});

 @override
 Widget build(BuildContext context) {
  return MaterialApp(
   title: 'Material App',
   initialRoute: 'splash',
   debugShowCheckedModeBanner: false,
   theme: ThemeCustomData.themeData(),
   routes: RoutesApp.getRoutes(),
  );
 }
}