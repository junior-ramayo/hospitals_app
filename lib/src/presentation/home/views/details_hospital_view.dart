import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/title_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/image_widget.dart';
import '../widgets/map_widget.dart';
import '../../../domain/entities/hospital.dart';
import '../widgets/sublabel.dart';

 class DetailsHospitalView extends StatelessWidget {

  final Hospital hospital;

  const DetailsHospitalView({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
   final homeBloc = BlocProvider.of<HomeBloc>(context);
   return Scaffold(
    body: LayoutBuilder(
     builder: (context, constraints) {
      return NestedScrollView(
       headerSliverBuilder: (context, value){
        return [
         SliverAppBar(
          expandedHeight: constraints.maxHeight * 0.26,
          pinned: true,
          elevation: 0,
          flexibleSpace: ImageWidget(
            width: double.infinity,
            imageURL: hospital.foto,
            fitImageError: BoxFit.cover,
          ),
          actions: [
           IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.favorite)
           ),
           IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.share)
           ),
          ],
         )
        ];
       }, 
       body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
         horizontal: constraints.maxWidth * 0.03
        ),
        child: Stack(
         children: [
          ListView(
           physics: const BouncingScrollPhysics(),
           children: [
            Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
              Expanded(
               child: TitleWidget(
                label: hospital.name,
                fontSize: constraints.maxWidth * 0.055,
               ),
              ),
              ImageWidget(
               width: constraints.maxWidth * 0.22,
               height: constraints.maxWidth * 0.13,
               imageURL: hospital.logo,
               fitImageNetWork: BoxFit.fill,
              )
             ],
            ),
            SubLabelWidget(
             label: hospital.horario,
             icon: Icons.watch_later_outlined,
             fontSize: constraints.maxWidth * 0.04,
             margin: const EdgeInsets.only(
              top: 17,
              bottom: 9
             ),
            ),
            SubLabelWidget(
             icon: Icons.phone,
             label: hospital.telefono,
             fontSize: constraints.maxWidth * 0.04,
             margin: const EdgeInsets.only(
              bottom: 9
             ),
            ),
            SubLabelWidget(
             icon: Icons.location_on,
             label: hospital.direccion,
             fontSize: constraints.maxWidth * 0.04,
             margin: const EdgeInsets.only(
              bottom: 20
             ),
            ),
            TitleWidget(
             label: "Ubicación",
             fontSize: constraints.maxWidth * 0.07,
            ),
            MapWidget(
             latitud: hospital.location.coordinates[1],
             longitud: hospital.location.coordinates[0],
            )
           ],
          ),
          Align(
           alignment: Alignment.bottomCenter,
           child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
             return CustomButton(
              label: 'Agendar cita',
              margin: const EdgeInsets.only(
               bottom: 17
              ),
              onPressed: state.buttonState == StateButtonAppointment.loading
              ? null
              : (){
               homeBloc.add(
                CreateAnAppointmentEvent(
                 hospitalId: hospital.id,
                 token: state.token!
                )
               );
              }
             );
            }
           ),
          )
         ],
        ),
       )
      );
     }
    )
   );
  }
 }