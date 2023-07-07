import 'package:dartz/dartz.dart';
import 'package:hospitals_app/src/domain/entities/user.dart';
import '../../../core/errors/failures.dart';



abstract class RegisterRepositories {


 Future<Either<Failure, User>> createUser({required User user});

}