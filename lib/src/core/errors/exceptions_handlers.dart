import 'dart:convert';

import 'package:http/http.dart' as http;



class ExceptionHandlers {

  static String getErrorCode(http.Response response){
   if (response.statusCode == 400) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if(jsonResponse["data"]["message"].toString().contains('Ya has hecho 3 solicitudes el día de hoy')){
     return "Solo puedes agendar tres citas al día";
    }
    return json.decode(response.body)['data']['message'];
   } else if (response.statusCode == 401) {
    return "Unauthorized";
   } else if (response.statusCode == 404) {
    return json.decode(response.body)['data']['message'];
   } else if (response.statusCode == 500) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse["data"]["message"].toString().contains('E11000 duplicate key')) {
     return 'El correo electrónico que ingresaste ya está asociado a otra cuenta';
    }
    if(jsonResponse["data"]["message"].toString().contains('username or password invalid')){
     return "Email o contraseña inválidos";
    }
    return json.decode(response.body)['data']['message'];
   } else {
    return 'Unknown error occured.';
   }
  }
 }