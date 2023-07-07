import 'dart:convert';
import '../../domain/entities/user.dart';



class UserModel extends User {
  
  UserModel({
   required super.userName, 
   required super.name, 
   required super.cellPhone,
   super.password
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  
  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
   userName: json["username"],
   name: json["name"],
   cellPhone: json["cellphone"],
  );

  factory UserModel.fromEntity({required User entity}) {
   return UserModel(
    userName: entity.userName,
    name: entity.name,
    cellPhone: entity.cellPhone,
    password: entity.password
   );
  }
  
  Map<String, dynamic> toMap() => {
   "username": userName,
   "name": name,
   "cellphone": cellPhone,
   "password": password
  };

}