import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static const _tokenKey = 'token';
  static const _languageKey = 'language';
  static const _isLoggedInKey = 'isLoggedIn';

  Future<void> saveToken(String token) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.remove(_tokenKey);
  }

  Future<void> saveLanguage(String language) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(_languageKey, language);
  }

  Future<String?> getLanguage() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(_languageKey);
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setBool(_isLoggedInKey, isLoggedIn);
  }

  Future<bool?> isLoggedIn() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getBool(_isLoggedInKey);
  }
}
