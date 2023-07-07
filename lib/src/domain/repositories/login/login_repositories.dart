import 'package:dartz/dartz.dart';
import 'package:hospitals_app/src/core/errors/failures.dart';
import '../../entities/user.dart';


abstract class LoginRepositories {

  Future<Either<Failure, String>> login({required User user});
 
}