import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/user.dart';
import '../../repositories/register/register_repositories.dart';



class RegisterUseCases {

  final RegisterRepositories registerRepositories;

  const RegisterUseCases({required this.registerRepositories});

  Future<Either<Failure, User>> createUserCase({required User user}){
   return registerRepositories.createUser(user: user);
  }
 


 }