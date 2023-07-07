import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitals_app/src/core/errors/validators.dart';
import 'package:hospitals_app/src/core/utils/custom_snackbar.dart';
import 'package:hospitals_app/src/presentation/register/bloc/register_bloc.dart';
import 'package:hospitals_app/src/presentation/widgets/custom_button.dart';
import 'package:hospitals_app/src/presentation/widgets/custom_input.dart';
import '../../../../injection_container.dart';
import '../../../core/utils/toast_animation.dart';
import '../widgets/register_header.dart';


class RegisterView extends StatelessWidget {


 const RegisterView({super.key});

 @override
 Widget build(BuildContext context) {
  return BlocProvider<RegisterBloc>(
   create: (context) => sl<RegisterBloc>(),
   child: BlocListener<RegisterBloc, RegisterState>(
     listener: (context, state) {
      if(state.errorMessage != ''){
       MySnackBar.show(context: context, label: state.errorMessage);
      }
      if(state.userResponse != null){
       MyToast.showToast(
        context: context,
        color: Colors.green,
        message: state.messageUI,
        duration: const Duration(seconds: 9),
        
       );
       Navigator.of(context).pop();
      }
     },
     child: Scaffold(
       resizeToAvoidBottomInset: false,
       body: Column(
        children: [
         const HeaderRegister(),
         Expanded(
          child: LayoutBuilder(
           builder: (context, constrains){
            return Container(
             margin: EdgeInsets.only(
              top: constrains.maxHeight * 0.05,
              left: constrains.maxWidth * 0.04,
              right: constrains.maxWidth * 0.04
             ),
             child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
               final registerBloc = BlocProvider.of<RegisterBloc>(context);
               return SingleChildScrollView(
                controller: registerBloc.scrollController,
                child: Form(
                 key: registerBloc.formKey,
                 child: Column(
                  children: [
                   CustomInput(
                    controller: registerBloc.emailController,
                    keyboardType: TextInputType.text,
                    hintText: "Correo electrónico",
                    suffixIcon: Icons.email,
                    focusNode: registerBloc.focusEmail,
                    validator: FieldValidator.validateEmail,
                    onEditingComplete: (){
                     FocusScope.of(context).requestFocus(registerBloc.focusPassword);
                     registerBloc.jump(widgetKey: registerBloc.keyPasswordController);
                    },
                   ),
                   CustomInput(
                    key: registerBloc.keyPasswordController,
                    controller: registerBloc.passwordController,
                    obscureText: state.obscurePassword,
                    keyboardType: TextInputType.text,
                    hintText: "Contraseña",
                    suffixIcon: registerBloc.suffixIcon(value: state.obscurePassword),
                    focusNode: registerBloc.focusPassword,
                    validator: FieldValidator.validatePassword,
                    onTapIcon: (){
                     registerBloc.add(WatchPasswordEvent());
                    },
                    onEditingComplete: (){
                     FocusScope.of(context).requestFocus(registerBloc.focusName);
                     registerBloc.jump(widgetKey: registerBloc.keyNameController);
                    },
                   ),
                   CustomInput(
                    key: registerBloc.keyNameController,
                    controller: registerBloc.nameController,
                    keyboardType: TextInputType.text,
                    hintText: "Nombre",
                    focusNode: registerBloc.focusName,
                    suffixIcon: Icons.person,
                    validator: FieldValidator.validateInput,
                    onEditingComplete: (){
                     FocusScope.of(context).requestFocus(registerBloc.focusPhoneNumber);
                     registerBloc.jump(widgetKey: registerBloc.keyCellPhoneController);
                    },
                   ),
                   CustomInput(
                    key: registerBloc.keyCellPhoneController,
                    controller: registerBloc.cellPhoneController,
                    keyboardType: TextInputType.number,
                    hintText: "Número telefónico",
                    focusNode: registerBloc.focusPhoneNumber,
                    suffixIcon: Icons.phone_android_rounded,
                    validator: FieldValidator.validatePhone,
                   ),
                   CustomButton(
                    label: 'Crear cuenta',
                    margin: EdgeInsets.only(
                     left: constrains.maxWidth * 0.04,
                     right: constrains.maxWidth * 0.04,
                     top: constrains.maxHeight * 0.03,
                     bottom: MediaQuery.of(context).viewInsets.bottom
                    ),
                    onPressed: (){
                     FocusManager.instance.primaryFocus?.unfocus();
                     if(registerBloc.formKey.currentState!.validate()){
                      registerBloc.add(CreateUserEvent());
                     }
                    }
                   )
                  ],
                 ),
                ),
               );
              }
             ),
            );
           }
          )
         )
        ],
       ),
      ),
   ),
  );
 }
}