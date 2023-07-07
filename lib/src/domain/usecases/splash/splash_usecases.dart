import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../repositories/splash/splash_repositories.dart';



 class SplashUseCases {

  final SplashRepositories splashRepositories;

  const SplashUseCases({required this.splashRepositories});

  Future<Either<Failure, String?>> checkLoginCase({required String key}){
   return splashRepositories.checkLogin(key: key);
  }
  

 }