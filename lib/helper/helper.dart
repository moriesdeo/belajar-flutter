class TokenManager {
  late String _token = '';

  String get token => _token;

  set token(String newToken) {
    _token = newToken;
  }
}
