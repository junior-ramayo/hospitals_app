import 'package:hospitals_app/src/core/errors/failures.dart';

import '../../../../core/utils/security_storage.dart';



abstract class HomeLocalDataSource {

  Future<void> deleteJWTDataSource({required String key});
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {

  final SecurityStorage securityStorage;
  
  const HomeLocalDataSourceImpl({required this.securityStorage});

  @override
  Future<void> deleteJWTDataSource({required String key}) {
   try {
    // throw CacheFailure(message: 'prueba');
    return securityStorage.deleteToken(key: key);
   }on CacheFailure catch(err){
    throw CacheFailure(message: err.message);
   }
  }

}