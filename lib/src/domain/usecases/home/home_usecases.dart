import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/hospital.dart';
import '../../repositories/home/home_repositories.dart';


class HomeUseCases {

 final HomeRepositories homeRepositories;

 const HomeUseCases({required this.homeRepositories});

 Future<Either<Failure, DataHospitals>> getAllHospitalsCase({
  required String token,
  required double lat,
  required double long,
  required String codeState,
  required int page
 }) async {
  return homeRepositories.getAllHospitals(
    token: token, 
    lat: lat, 
    long: long, 
    codeState: codeState,
    page: page
  );
 }

 Future<Either<Failure, bool>> createAnAppointmentCase({required String hospitalId, required String token}){
  return homeRepositories.createAnAppointment(hospitalId: hospitalId, token: token);
 }

}