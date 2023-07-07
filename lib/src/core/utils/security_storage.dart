import 'package:flutter_secure_storage/flutter_secure_storage.dart';

 class SecurityStorage {

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
   encryptedSharedPreferences: true,
  );
  
  final _storage = FlutterSecureStorage(
   aOptions: _getAndroidOptions()
  );

  Future<String?> readToken({required String key}) async {
   return await _storage.read(key: key); 
  }

  Future<void> saveToken({required String key, required String token}) async {
   return await _storage.write(key: key, value: token);
  }

  Future<void> deleteToken({required String key}) async {
   await _storage.delete(key: key);
  }


 }