import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';



abstract class SplashRepositories {

  Future<Either<Failure, String?>> checkLogin({required String key});
}