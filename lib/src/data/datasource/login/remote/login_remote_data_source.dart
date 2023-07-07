import 'dart:convert';

import 'package:hospitals_app/src/core/errors/failures.dart';
import 'package:hospitals_app/src/core/global/environment.dart';
import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions_handlers.dart';
import '../../../model/user_model.dart';

 /* 
  Esta es una clase abstracta LoginRemoteDataSource que define un contrato 
  para un inicio de sesión. Tiene un método loginDataSource que toma un parámetro 
  userModel de tipo UserModel y devuelve un Future que contiene el valor del JWT.
 */
 abstract class LoginRemoteDataSource {

  Future<String> loginDataSource({required UserModel userModel});
 }

 class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {

  final http.Client client;

  const LoginRemoteDataSourceImpl({required this.client});


  /* 
  Login a la API https://meddi-training.vercel.app/api/v1/user/login
  */
  @override
  Future<String> loginDataSource({required UserModel userModel}) async {
   try{
 
    final url = Uri.parse('${Environment.apiUrl}/user/login');
    final response = await client.post(
     url,
     headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8'
     },
     body: jsonEncode({
      "username": userModel.userName,
      "password": userModel.password!
     })
    );
    /* 
    Se verifica el código de estado de la respuesta para determinar si la solicitud fue exitosa.
    Si el código de estado es 200, se extrae el token de autenticación del cuerpo de la respuesta JSON 
    utilizando json.decode. El token se asigna a la variable token de tipo String
    */
    if(response.statusCode == 200){
     final String token = json.decode(response.body)["data"]["jwtToken"];
     return token;
    } else {
     /* 
     Si el código de estado no es 200, se lanza una excepción ServerFailure con un mensaje 
     obtenido a partir del código de error de la respuesta utilizando ExceptionHandlers.getErrorCode(response).
     */
     throw ServerFailure(message: ExceptionHandlers.getErrorCode(response));
    }

   } on ServerFailure catch(err){
    /*
    Si ocurre una excepción de tipo ServerFailure, 
    se lanza nuevamente con el mismo mensaje para propagar el error.
    */
    throw ServerFailure(message: err.message);
   }
  }

 }