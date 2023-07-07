import 'package:dartz/dartz.dart';
import 'package:hospitals_app/src/core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/register/register_repositories.dart';
import '../../datasource/register/remote/register_remote_data_source.dart';
import '../../model/user_model.dart';



class RegisterRepositoryImpl implements RegisterRepositories {

 final RegisterRemoteDataSource remoteDataSource;
 final NetworkInfo networkInfo;

 const RegisterRepositoryImpl({
  required this.remoteDataSource,
  required this.networkInfo
 });

  /* 
  Función para crear un usuario en la base de datos, recibimos un entity
  */
  @override
  Future<Either<Failure, User>> createUser({required User user}) async {
   /* 
   Aquí se verifica si hay una conexión a Internet disponible utilizando networkInfo.isConnected
   */
   if(await networkInfo.isConnected){
    try{

     /* 
      Si hay conexión a Internet, se convierte el objeto user en un UserModel 
      utilizando UserModel.fromEntity. Esto permite que la capa de datos del repositorio 
      trabaje con el modelo de datos interno sin exponer directamente la clase User.
     */
     final newUser = UserModel.fromEntity(entity: user);
     /* 
     pasamos el modelo como parámetro en la función `registerUserDataSource`. 
     Si obtenemos una respuesta exitosa, regresamos el nuevo usuario.
     */
     final userResponse = await remoteDataSource.registerUserDataSource(user: newUser);
     return Right(userResponse);
    }on ServerFailure catch(err){
     return Left(ServerFailure(message: err.message));
    }
   } else {
    /* 
     Si no hay conexión a Internet, se devuelve un Left con un InternetFailure (fracaso de Internet) 
     y un mensaje que indica que no hay conexión a Internet.
    */
    return const Left(InternetFailure(message: "Ups!, No tienes conexión a internet"));
   }
  }

  
}