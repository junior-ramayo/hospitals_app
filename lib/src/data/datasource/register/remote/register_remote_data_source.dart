import 'dart:async';
import 'dart:convert';
import 'package:hospitals_app/src/core/errors/failures.dart';
import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions_handlers.dart';
import '../../../../core/global/environment.dart';
import '../../../model/user_model.dart';


 /* 
 Esta es una clase abstracta RegisterRemoteDataSource que define un contrato 
 para una fuente de datos remota de registro de usuario. Tiene un método 
 registerUserDataSource que toma un parámetro user de tipo UserModel y devuelve 
 un Future que contiene un objeto UserModel
 */
 abstract class RegisterRemoteDataSource {

  Future<UserModel> registerUserDataSource({required UserModel user});
 }

 class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {

  final http.Client client;

  const RegisterRemoteDataSourceImpl({required this.client});
  
  /* 
  Hacemos una llamada http post para crear un nuevo usuario en la base de datos.
  API: https://meddi-training.vercel.app/api/v1/user/create
  */
  @override
  Future<UserModel> registerUserDataSource({required UserModel user}) async {
   try{
    //Se define una URL para la solicitud POST al endpoint de registro de usuario
    final url = Uri.parse("${Environment.apiUrl}/user/create");
    /* 
     Se especifica la URL, los encabezados y el cuerpo de la solicitud. 
     El encabezado Content-Type se establece como JSON. El cuerpo de la 
     solicitud se obtiene llamando al método toJson en el objeto user.
    */
    final response = await client.post(
     url, 
     headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8'
     },
     body: user.toJson()
    );
    /* 
     Si el código de estado es 200, se extrae el objeto "user" de la respuesta JSON y se 
     convierte en un objeto UserModel utilizando UserModel.fromJson.
     El objeto UserModel se devuelve.
    */
    if(response.statusCode == 200){
     final jsonResponse = jsonDecode(response.body)["data"]["user"];
     return UserModel.fromJson(json.encode(jsonResponse));
    } else {
     /* 
     Si el código de estado no es 200, se lanza una excepción ServerFailure con un mensaje 
     obtenido del código de error de la respuesta utilizando ExceptionHandlers.getErrorCode(response).
     */
     throw ServerFailure(message: ExceptionHandlers.getErrorCode(response));
    }

   } on ServerFailure catch(err){
    /* 
    Si se produce un ServerFailure durante el manejo de la solicitud, 
    se captura la excepción en err y se lanza nuevamente con el mismo mensaje para propagar el error:
    */
    throw ServerFailure(message: err.message);
   }
  }

 }