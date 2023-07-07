import 'package:dartz/dartz.dart';
import 'package:hospitals_app/src/domain/repositories/login/login_repositories.dart';

import '../../../core/errors/failures.dart';
import '../../entities/user.dart';

 class LoginUseCases {

  final LoginRepositories loginRepositories;

  const LoginUseCases({required this.loginRepositories});

  Future<Either<Failure, String>> loginUseCase({required User user}){
   return loginRepositories.login(user: user);  
  }
  

 }