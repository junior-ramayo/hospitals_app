import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitals_app/injection_container.dart';
import 'package:hospitals_app/src/core/utils/custom_snackbar.dart';
import '../../../core/colors/colors_app.dart';
import '../../../core/errors/validators.dart';
import '../../../core/styles/custom_text_style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';
import '../bloc/login_bloc.dart';


 class LoginView extends StatelessWidget {


  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocProvider<LoginBloc>(
    create: (context) => sl<LoginBloc>(),
    child: BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
       /*
       Si la variable JWT en el LoginState es diferente de Empty quiere decir 
       que hicimos un inicio de sesión exitoso y podemos permitirle al usuario 
       entrar a la app.

       Enviamos como argumento el JWT para poder usarlo en el HomeView y hacer las llamadas a la DB
       */
       if(state.jwt.isNotEmpty){
        Navigator.of(context).pushNamedAndRemoveUntil(
         'home', 
         (route) => false, 
         arguments: {
          "jwt": state.jwt
         }
        );
       }
       if(state.errorMessage.isNotEmpty){
        MySnackBar.show(context: context, label: state.errorMessage);
       }
      },
      child: Scaffold(
         resizeToAvoidBottomInset: false,
         body: Container(
            decoration: BoxDecoration(
             gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: ColorsApp.backgroundColor()
             )
            ),
            alignment: Alignment.topRight,
            child: LayoutBuilder(
             builder: (context, size) {
              return ClipRRect(
               borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(70)
               ),
               child: Container(
                width: size.maxWidth * 0.85,
                height: size.maxHeight * 0.92,
                padding: EdgeInsets.symmetric(
                 horizontal: size.maxWidth * 0.06
                ),
                decoration: const BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                 )
                ),
                child: LayoutBuilder(
                 builder: (context, constrain) {
                  return SafeArea(
                   child: SingleChildScrollView(
                    child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                      Padding(
                       padding: const EdgeInsets.only(top: 20.0, bottom: 35),
                       child: Image.asset(
                        'assets/images/login_image.png',
                        fit: BoxFit.cover,
                        height: constrain.maxHeight * 0.18,
                       ),
                      ),
                      Text(
                       'Bienvenido',
                       style: TextStyle(
                        fontFamily: CustomTextStyle.mainText,
                        fontSize: constrain.maxWidth * 0.11,
                        color: Colors.black,
                        fontWeight: FontWeight.w700
                       ),
                      ),
                      Container(
                       margin: EdgeInsets.symmetric(
                        vertical: constrain.maxHeight * 0.045
                       ),
                       child: BlocBuilder<LoginBloc, LoginState>(
                         builder: (context, state) {
                          final loginBloc = BlocProvider.of<LoginBloc>(context);
                          return Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                            Form(
                             key: loginBloc.formKey,
                             child: Column(
                              children: [
                               CustomInput(
                                hintText: 'Username',
                                suffixIcon: Icons.email,
                                controller: loginBloc.emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: FieldValidator.validateInput,
                                margin: const EdgeInsets.only(top: 20, bottom: 25, right: 5),
                               ),
                               CustomInput(
                                obscureText: loginBloc.state.obscurePassword,
                                controller: loginBloc.passController,
                                suffixIcon: loginBloc.suffixIcon(value: loginBloc.state.obscurePassword),
                                onTapIcon: (){
                                 loginBloc.add(LoginWatchPassEvent());
                                },
                                validator: FieldValidator.validatePassLogin,
                                keyboardType: TextInputType.text,
                                hintText: 'Password',
                                margin: const EdgeInsets.only(bottom: 25, right: 5),
                               )
                              ],
                             ),
                            ),
                            CustomButton(
                             label: 'Log in',
                             minimumSize: Size(
                              double.infinity,
                              constrain.maxHeight * 0.055
                             ),
                             fontSize: constrain.maxWidth * 0.063,
                             onPressed: state.buttonState == LoginButtonState.loading
                             ? null
                             : (){
                              FocusManager.instance.primaryFocus?.unfocus();
                              if(loginBloc.formKey.currentState!.validate()){
                               loginBloc.add(LoginUserEvent());
                              }
                             },
                            ),
                            Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                              Padding(
                               padding: const EdgeInsets.only(right: 2.0),
                               child: Text(
                                'No tienes cuenta?',
                                style: TextStyle(
                                 fontFamily: CustomTextStyle.bodyText,
                                 fontWeight: FontWeight.bold,
                                 fontSize: constrain.maxWidth * 0.046
                                ),
                               ),
                              ),
                              TextButton(
                               onPressed: (){
                                Navigator.of(context).pushNamed('register');
                               },
                               child: Text(
                                'Regístrate',
                                style: TextStyle(
                                 fontFamily: CustomTextStyle.bodyText,
                                 fontSize: constrain.maxWidth * 0.046
                                ),
                               ),
                              ),
                             ],
                            ),
                           ],
                          );
                         }
                       ),
                      )
                     ],
                    ),
                   ),
                  );
                 }
                ),
               ),
              );
             }
            ),
           ),
        ),
    ),
   );
  }
 }