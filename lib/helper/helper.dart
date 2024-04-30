import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrefManager {
  static const _tokenKey = 'token';
  static const _languageKey = 'language';
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

  Future<void> saveLanguage(String language) async {
    await storage.write(key: _languageKey, value: language);
  }

  Future<String?> getLanguage() async {
    return await storage.read(key: _languageKey);
  }
}