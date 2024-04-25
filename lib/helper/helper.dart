import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const _tokenKey = 'token';
  final storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: _tokenKey);
  }
}
