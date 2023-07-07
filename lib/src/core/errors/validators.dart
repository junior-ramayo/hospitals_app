


class FieldValidator {

 static String? validateEmail(String? value){
  if (value == null || value.isEmpty) {
   return 'Ingresa un email';
  }
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);
 
  if (!regExp.hasMatch(value)) {
   return 'Ingresa un email valido';
  }
  return null;
 }

 static String? validatePassLogin(String? value){
  if (value == null || value.isEmpty) {
   return 'Ingresa tu contraseña';
  }
  return null;
 }
 
 static String? validatePassword(String? value){
  if (value == null || value.isEmpty) {
   return 'Ingresa una contraseña';
  }
  if(value.length < 6){
    return 'Ingresa 6 dígitos';
  }
  RegExp specialCharacter = RegExp(r"(?=.*\W)");
  if(!specialCharacter.hasMatch(value)){
   return 'Ingresa al menos un carácter especial';
  }
  RegExp mayusPass = RegExp(r"(?=.*[A-Z])");
  if(!mayusPass.hasMatch(value)){
   return 'Debes ingresar al menos una mayúscula';
  }
  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])");
  if(!passValid.hasMatch(value)){
   return 'Contraseña muy débil, ingresa letras y números';
  }
  return null;
 }
 
 static String? validatePhone(String? value){
  if (value == null || value.isEmpty) {
   return 'Ingresa un número telefónico';
  }
  if (value.length < 10 || value.length > 10) {
   return 'Ingresa un número válido';
  }
  return null;
 }
 
 static String? validateName(String? value){
  if (value == null || value.isEmpty) {
   return 'Ingresa un nombre';
  }
  return null;
 }

 static String? validateInput(String? value){
  if(value == null || value.isEmpty){
   return "Este campo no puede estar vacío";
  }
  return null;
 }
 
}