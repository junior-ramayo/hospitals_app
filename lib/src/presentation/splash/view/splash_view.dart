import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitals_app/src/presentation/splash/bloc/splash_bloc.dart';

import '../../../../injection_container.dart';
import '../../../core/colors/colors_app.dart';
import '../../../core/styles/custom_text_style.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  double scale = 5.0;

  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_) {
    setState(() {
     scale = 1.0;
    });
   });
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: BlocProvider<SplashBloc>(
     create: (context) => sl<SplashBloc>(),
     child: BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
       /* 
        Si el state.stateLogin es igual a loggedIn, quiere decir que hay un 
        inicio de sesión activo, por lo tanto, hacemos un pushNamedAndRemoveUntil al HomeView.
       */
       if(state.stateLogin == StateLogin.loggedIn){
        Navigator.of(context).pushNamedAndRemoveUntil(
         'home', 
         (route) => false,
         arguments: {
          'jwt': state.token
         }
        );
       }
       
       /* 
       Si el state.stateLogin es igual a notLoggedIn o errorLogin, 
       quiere decir que no hay un inicio de sesión activo o no pudimos 
       verificar si hay inicio de sesión activo, por lo tanto, mandamos 
       al usuario al LoginView
       */
       if(state.stateLogin == StateLogin.notLoggedIn || state.stateLogin == StateLogin.errorLogin){
        Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
       }
      },
      child: Container(
       decoration: BoxDecoration(
        gradient: LinearGradient(
         begin: Alignment.topRight,
         end: Alignment.bottomLeft,
         colors: ColorsApp.backgroundColor()
        )
       ),
       height: double.infinity,
       width: double.infinity,
       child: Center(
        child: BlocBuilder<SplashBloc, SplashState>(
         builder: (context, state) {
          final splashBloc = BlocProvider.of<SplashBloc>(context);
          return Stack(
           children: [
            AnimatedPositioned(
             duration: const Duration(seconds: 2),
             curve: Curves.bounceOut,
             height: getHeight(),
             width: getWidth(),
             top: MediaQuery.of(context).size.height / 2 - getHeight() / 2,
             left: MediaQuery.of(context).size.width / 2 - getWidth() / 2,
             onEnd: () {
              splashBloc.add(CheckLoginEvent());
             },
             child: const FittedBox(
              fit: BoxFit.contain,
              child: Text(
               'Bienvenido',
               style: TextStyle(
                fontFamily: CustomTextStyle.mainText,
                fontWeight: FontWeight.bold,
                color: Colors.white,
               ),
              ),
             ),
            ),
           ]
          );
         }
        ),
       ),
      ),
     ),
    ),
   );
  }

  double getHeight() {
    return 60 * scale;
  }

  double getWidth() {
    return 120 * scale;
  }
}