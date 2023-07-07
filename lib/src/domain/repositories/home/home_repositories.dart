import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/hospital.dart';


abstract class HomeRepositories {

  Future<Either<Failure, DataHospitals>> getAllHospitals({
   required String token,
   required double lat,
   required double long,
   required String codeState,
   required int page
  });

  Future<Either<Failure, bool>> createAnAppointment({required String hospitalId, required String token});
  
}