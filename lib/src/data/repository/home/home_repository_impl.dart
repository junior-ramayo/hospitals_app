import 'package:dartz/dartz.dart';
import 'package:hospitals_app/src/core/errors/failures.dart';
import 'package:hospitals_app/src/data/datasource/home/remote/home_remote_data_source.dart';
import 'package:hospitals_app/src/domain/repositories/home/home_repositories.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/entities/hospital.dart';
import '../../datasource/home/local/home_local_data_source.dart';



class HomeRepositoryImpl implements HomeRepositories {

 final HomeRemoteDataSource remoteDataSource;
 final HomeLocalDataSource localDataSource;
 final NetworkInfo networkInfo;

 const HomeRepositoryImpl({
  required this.remoteDataSource,
  required this.localDataSource,
  required this.networkInfo
 });


  /* 
  getAllHospitals devuelve un objeto Future que contiene un Either que puede ser un 
  Failure o una instancia de DataHospitals.
  
  Acepta varios parámetros requeridos: token (String), lat (double), 
  long (double), codeState (String) y page (int).
  */
  @override
  Future<Either<Failure, DataHospitals>> getAllHospitals({
   required String token,
   required double lat,
   required double long,
   required String codeState,
   required int page
  }) async {
   /* 
   La siguiente línea de código verifica si el dispositivo está conectado a Internet 
   mediante el uso de networkInfo.isConnected.
   Si el dispositivo está conectado a Internet, el código dentro del bloque if se ejecuta.
   */
   if (await networkInfo.isConnected) {
    try {
      /*
       se realiza llamando a getAllHospitalsDataSource con los parámetros proporcionados. Si se 
       obtiene la lista de hospitales correctamente, se devuelve un objeto Right que contiene 
       la lista
       */
     final listHospitals = await remoteDataSource.getAllHospitalsDataSource(
      token: token,
      lat: lat,
      long: long,
      codeState: codeState,
      page: page
     );
     return Right(listHospitals);
    } on ServerFailure catch(err){
      /* 
      Si se produce una excepción del tipo ServerFailure, se captura en el bloque catch. 
      Aquí se verifica si el mensaje de la excepción es "Unauthorized".
      */
      if(err.message == "Unauthorized"){
       try{
        /* 
        Si el mensaje es "Unauthorized", se intenta eliminar la clave de autenticación almacenada 
        en el Storage. Luego se devuelve un objeto Left con un mensaje indicando que la sesión ha expirado
        */
        await localDataSource.deleteJWTDataSource(key: 'token');
        return const Left(ServerFailure(message: "Tu sesión ha expirado"));
       }on CacheFailure catch(err){
        return Left(CacheFailure(message: err.message));
       }
      }
      /* 
      Si el mensaje de la excepción ServerFailure no es "Unauthorized", 
      se devuelve un objeto Left con el mensaje de error de la excepción.
      */
      return Left(ServerFailure(message: err.message));
    }
   } else {
    /*
    Si el dispositivo no está conectado a Internet,
    se devuelve un objeto Left indicando una falla de conexión a Internet.
    */
    return const Left(InternetFailure(message: "Ups!, No tienes conexión a internet"));
   }
  }


  /* 
  función llamada createAnAppointment que devuelve un objeto Future que contiene 
  un Either que puede ser un Failure o una .

  La función acepta varios parámetros requeridos: token (String), lat (double), 
  long (double), codeState (String) y page (int).
  */
  @override
  Future<Either<Failure, bool>> createAnAppointment({required String hospitalId, required String token}) async {
   /* 
    La siguiente línea de código verifica si el dispositivo está conectado a Internet 
    mediante el uso de networkInfo.isConnected.
    Si el dispositivo está conectado a Internet, el código dentro del bloque if se ejecuta.
   */
   if (await networkInfo.isConnected) {
    try {
     /* 
     Se realiza un intento de crear una cita llamando a createAnAppointmentDataSource en remoteDataSource. 
     hospitalId y token se pasan como parámetros. Si tiene éxito, se devuelve un Right (derecha) que 
     contiene la respuesta (confirm).
     */
     final confirm = await remoteDataSource.createAnAppointmentDataSource(hospitalId: hospitalId, token: token);
     return Right(confirm);
    } on ServerFailure catch(err){
      /* 
      Si se produce una excepción del tipo ServerFailure, se captura en el bloque catch. 
      Aquí se verifica si el mensaje de la excepción es "Unauthorized".
      */
      if(err.message == "Unauthorized"){
       try{
        /* 
        Si el mensaje es "Unauthorized", se intenta eliminar la clave de autenticación almacenada 
        en el Storage. Luego se devuelve un objeto Left con un mensaje indicando que la sesión ha expirado
        */
        await localDataSource.deleteJWTDataSource(key: 'token');
        return const Left(ServerFailure(message: "Tu sesión ha expirado"));
       }on CacheFailure catch(err){
        return Left(CacheFailure(message: err.message));
       }
      }
      /* 
      Si el mensaje de la excepción ServerFailure no es "Unauthorized", 
      se devuelve un objeto Left con el mensaje de error de la excepción.
      */
      return Left(ServerFailure(message: err.message));
    }
   } else {
    /*
    Si el dispositivo no está conectado a Internet,
    se devuelve un objeto Left indicando una falla de conexión a Internet.
    */
    return const Left(InternetFailure(message: "Ups!, No tienes conexión a internet"));
   }
  }


}