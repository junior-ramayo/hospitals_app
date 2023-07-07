import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitals_app/src/core/utils/toast_animation.dart';
import '../../../../injection_container.dart';
import '../../../core/styles/custom_text_style.dart';
import '../../../core/utils/navigation_animation.dart';
import '../bloc/home_bloc.dart';
import '../views/details_hospital_view.dart';
import 'custom_header.dart';
import 'hospital_item_list.dart';

 class HomeBody extends StatelessWidget {

  final Map<String, dynamic> dataPosition;
  final String jwt;
  
  const HomeBody({super.key, required this.dataPosition, required this.jwt});

  @override
  Widget build(BuildContext context) {
   return BlocProvider<HomeBloc>(
    create: (context) => sl<HomeBloc>()..add(
     GetAllHospitalsEvent(
      token: jwt,
      lat: dataPosition["latitud"],
      long: dataPosition["longitud"],
      codeState: dataPosition["codeState"],
      page: 1
     )
    ),
    child: SafeArea(
     bottom: false,
     child: BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
       if(state.messageError != ""){
        MyToast.showToast(
         context: context, 
         message: state.messageError, 
         duration: const Duration(seconds: 7)
        );
       }
       /* 
       Si el mensaje de error es igual a 'Tu sesión ha expirado', quiere decir 
       que el token expiró y mandamos al usuario al login
       */
       if(state.messageError == "Tu sesión ha expirado"){
        Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
       }
       if(state.buttonState == StateButtonAppointment.loaded){
        MyToast.showToast(
         context: context, 
         message: "Cita creada",
         color: Colors.green,
         duration: const Duration(seconds: 7)
        );
       }
      },
      child: Column(
       children: [
        const CustomHeaderHome(),
        Expanded(
         child: LayoutBuilder(
          builder: (context,constraints) {
           return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
             final homeBloc = BlocProvider.of<HomeBloc>(context);
             switch(state.getDataState){
              case StateGetData.loading:
               return const Center(child: CircularProgressIndicator());
              case StateGetData.error:
               return const Center(
                child: Text(
                 'No data',
                 style: TextStyle(
                  fontFamily: CustomTextStyle.bodyText
                 )
                )
               );
              case StateGetData.loaded:
               return  ListView.builder(
                controller: homeBloc.scrollController,
                itemCount: state.dataHospitals!.hospitals.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                 horizontal: constraints.maxWidth * 0.045
                ),
                itemBuilder: (context, index){
                 return HospitalItemWidget(
                  constraints: constraints,
                  hospital: state.dataHospitals!.hospitals[index],
                  onTap: (){
                   Navigator.of(context).push(
                    SlideAnimationRoute(
                     page: BlocProvider<HomeBloc>.value(
                      value: BlocProvider.of<HomeBloc>(context),
                      child: DetailsHospitalView(
                       hospital: state.dataHospitals!.hospitals[index],
                      )
                     )
                    )
                   );
                  },
                 );
                }
               );
              default:
               return const SizedBox.shrink();
             }
            }
           );
          }
         ),
        )
       ],
      ),
     )
    ),
   );
  }
 }