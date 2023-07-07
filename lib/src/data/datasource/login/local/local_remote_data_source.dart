import 'package:hospitals_app/src/core/errors/failures.dart';
import '../../../../core/utils/security_storage.dart';


 abstract class LoginLocalDataSource {

  Future<void> saveTokenUser({required String key, required String token});
 }

 class LoginLocalDataSourceImpl implements LoginLocalDataSource {

  final SecurityStorage securityStorage;

  const LoginLocalDataSourceImpl({required this.securityStorage});
  
  @override
  Future<void> saveTokenUser({required String key, required String token}) async {
   try{
    return await securityStorage.saveToken(key: key, token: token);
   }on CacheFailure catch(err){
    throw CacheFailure(message: err.message);
   }
  }



 }