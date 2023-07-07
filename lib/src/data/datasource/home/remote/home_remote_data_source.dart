import 'dart:convert';
import 'package:hospitals_app/src/core/global/environment.dart';
import 'package:hospitals_app/src/data/model/hospital_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions_handlers.dart';
import '../../../../core/errors/failures.dart';


abstract class HomeRemoteDataSource {

  Future<DataHospitalsModel> getAllHospitalsDataSource({
   required String token,
   required double lat,
   required double long,
   required String codeState,
   required int page
  });
  Future<bool> createAnAppointmentDataSource({required String hospitalId, required String token});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {

  final http.Client client;

  const HomeRemoteDataSourceImpl({required this.client});
  

  /* 
  Obtenemos la lista de hospitales paginados de la API 
  https://meddi-training.vercel.app/api/v1/hospital/get/all?page=$page&rowsPerPage=10&lat=$lat&long=$long&estadoCode=$codeState
  */
  @override
  Future<DataHospitalsModel> getAllHospitalsDataSource({
    required String token, 
    required double lat,
    required double long,
    required String codeState,
    required int page
  }) async {
   try{
    /* 
    Se realiza una solicitud GET a una URL construida usando los parámetros proporcionados 
    y las variables de entorno (Environment.apiUrl). Se agrega el token de autenticación al 
    encabezado de la solicitud. La respuesta se almacena en la variable response.
    */
    final url = Uri.parse("${Environment.apiUrl}/hospital/get/all?page=$page&rowsPerPage=10&lat=$lat&long=$long&estadoCode=$codeState");
    final response = await client.get(
     url, 
     headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
     }
    );
    /* 
    Se verifica si el código de estado de la respuesta es 200, lo que indica una respuesta exitosa. 
    Si es así, se extrae el objeto "data" de la respuesta JSON y se convierte en un objeto DataHospitalsModel 
    utilizando el método fromJson.
    */
    if(response.statusCode == 200){
     final jsonResponse = jsonDecode(response.body)["data"];
     return DataHospitalsModel.fromJson(json.encode(jsonResponse));
    } else {
     /* 
     Si el código de estado no es 200, se lanza una excepción ServerFailure con un mensaje 
     obtenido a partir del código de error de la respuesta utilizando ExceptionHandlers.getErrorCode(response).
     */
     throw ServerFailure(message: ExceptionHandlers.getErrorCode(response));
    }
   }on ServerFailure catch(err){
    /* 
    Si ocurre una excepción de tipo ServerFailure, 
    se lanza nuevamente con el mismo mensaje para propagar el error.
    */
    throw ServerFailure(message: err.message);
   }
  }
  

  /* 
  Creamos una cita en la API https://meddi-training.vercel.app/api/v1/solicitud/create
  */
  @override
  Future<bool> createAnAppointmentDataSource({required String hospitalId, required String token}) async {
   try{
    /*
    Se realiza una solicitud POST a una URL específica (/solicitud/create) utilizando 
    el endpoint de la API proporcionado por Environment.apiUrl. Se agrega el token de 
    autenticación al encabezado de la solicitud. El parámetro hospitalId se envía en el 
    cuerpo de la solicitud como datos.
    */
    final url = Uri.parse("${Environment.apiUrl}/solicitud/create");
    final response = await client.post(
     url,
     headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
     },
     body: {
      "hospitalId": hospitalId
     }
    );
    /* 
    Se verifica si el código de estado de la respuesta es 200, lo que indica una 
    respuesta exitosa. Si es así, se devuelve true para indicar que la cita se 
    creó correctamente.
    */
    if(response.statusCode == 200){
     return true;
    } else {
      /* 
     Si el código de estado no es 200, se lanza una excepción ServerFailure con un mensaje 
     obtenido a partir del código de error de la respuesta utilizando
     ExceptionHandlers.getErrorCode(response).
     */
      throw ServerFailure(message: ExceptionHandlers.getErrorCode(response));
    }

   }on ServerFailure catch(err){
    /* 
    Si ocurre una excepción de tipo ServerFailure, 
    se lanza nuevamente con el mismo mensaje para propagar el error.
    */
    throw ServerFailure(message: err.message);    
   }
  }


}