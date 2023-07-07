import 'package:hospitals_app/src/core/errors/failures.dart';
import 'package:hospitals_app/src/core/utils/security_storage.dart';


 abstract class SplashLocalDataSource {

  Future<String?> checkLoginDataSource({required String key});
 }

 class SplashLocalDataSourceImpl implements SplashLocalDataSource {

  final SecurityStorage securityStorage;


  const SplashLocalDataSourceImpl({required this.securityStorage});
  
  @override
  Future<String?> checkLoginDataSource({required String key}) async{
   try{

    return await securityStorage.readToken(key: key);

   }on CacheFailure catch(err){
    throw CacheFailure(message: err.message);
   }
  }




 }