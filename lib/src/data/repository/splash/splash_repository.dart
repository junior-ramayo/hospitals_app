import 'package:dartz/dartz.dart';
import 'package:hospitals_app/src/core/errors/failures.dart';
import 'package:hospitals_app/src/data/datasource/splash/local/splash_local_data_source.dart';
import '../../../domain/repositories/splash/splash_repositories.dart';

 class SplashRepositoryImpl implements SplashRepositories {

  final SplashLocalDataSource localDataSource;

  const SplashRepositoryImpl({required this.localDataSource});

  // Revisamos si el usuario está logueado o no
  @override
  Future<Either<Failure, String?>> checkLogin({required String key}) async {
   try{
    /* 
     Buscamos en el storage si existe un token. Si nos regresa un valor null, 
     quiere decir que no hay ningún token almacenado, por lo tanto, no está logueado. 
     Si nos regresa un String, quiere decir que está logueado.
    */
    final token = await localDataSource.checkLoginDataSource(key: key);
    return Right(token);

   }on CacheFailure catch(err){
    return Left(CacheFailure(message: err.message));
   }
  }

 }