import 'package:dartz/dartz.dart';
import 'package:hospitals_app/src/core/errors/failures.dart';
import 'package:hospitals_app/src/core/network/network_info.dart';
import 'package:hospitals_app/src/data/datasource/login/local/local_remote_data_source.dart';
import 'package:hospitals_app/src/data/datasource/login/remote/login_remote_data_source.dart';
import 'package:hospitals_app/src/domain/entities/user.dart';
import 'package:hospitals_app/src/domain/repositories/login/login_repositories.dart';

import '../../model/user_model.dart';



class LoginRepositoryImpl implements LoginRepositories {

  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const LoginRepositoryImpl({
   required this.remoteDataSource,
   required this.localDataSource,
   required this.networkInfo
  });


  @override
  Future<Either<Failure, String>> login({required User user}) async {
   /* 
   La siguiente línea de código verifica si el dispositivo está conectado a Internet 
   mediante el uso de networkInfo.isConnected.
   Si el dispositivo está conectado a Internet, el código dentro del bloque if se ejecuta.
   */
   if(await networkInfo.isConnected){
    try{
     /* 
      Si hay conexión a Internet, se convierte el objeto user en un UserModel 
      utilizando UserModel.fromEntity. Esto permite que la capa de datos del repositorio 
      trabaje con el modelo de datos interno sin exponer directamente la clase User.
     */
     final UserModel userModel = UserModel.fromEntity(entity: user);
     /*
     Se llama al método login de remoteDataSource, pasando el UserModel,
      para realizar la solicitud de inicio de sesión a través del LoginRemotedataSource. 
      Esto devuelve un token de autenticación como un String.
     */
     final tokenResponse = await remoteDataSource.loginDataSource(userModel: userModel);
     /* 
     El token de autenticación se guarda en localDataSource utilizando el método saveTokenUser. 
     Esto permite almacenar el token localmente para su uso posterior en la aplicación.
     */
     await localDataSource.saveTokenUser(key: 'token', token: tokenResponse);
     //Finalmente, se devuelve el token de autenticación como un Right
     return Right(tokenResponse);
    } on ServerFailure catch(err){
     return Left(ServerFailure(message: err.message));
    }
   } else {
    /*
    Si el dispositivo no está conectado a Internet, se devuelve 
    un objeto Left indicando una falla de conexión a Internet.
    */
    return const Left(InternetFailure(message: "Ups!, No tienes conexión a internet"));
   }
  }

}