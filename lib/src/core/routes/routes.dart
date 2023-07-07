import 'package:flutter/material.dart';
import '../../presentation/home/views/home_view.dart';
import '../../presentation/login/view/login_view.dart';
import '../../presentation/register/view/register_view.dart';
import '../../presentation/splash/view/splash_view.dart';


class RoutesApp {
  
 static Map<String, Widget Function(BuildContext)> getRoutes(){
  return {
   "splash": (BuildContext context) => const SplashView(),
   "login": (BuildContext context) =>  const LoginView(),
   "register": (BuildContext context) => const RegisterView(),
   "home": (BuildContext context) => const HomeView(),
  };
 }
}