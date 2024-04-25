import 'package:belajar_flutter/data/repositories.dart';
import 'package:belajar_flutter/domain/use_case.dart';
import 'package:belajar_flutter/domain/viewmodel.dart';
import 'package:belajar_flutter/helper/helper.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'dart:convert';

GetIt getit = GetIt.instance;

void setupLocator() {
  getit.registerLazySingleton(
      () => http.Client()); // Ensuring the HTTP client is available
  getit.registerLazySingleton(
      () => TokenManager()); // Token Manager to manage authentication tokens
  getit.registerLazySingleton(() => APIClient(
      'https://story-api.dicoding.dev/v1',
      client: getit<http.Client>(),
      tokenManager: getit<TokenManager>()));
  getit.registerLazySingleton<DataRepository>(
      () => DataRepositoryImpl(getit<APIClient>()));
  getit.registerFactory(() => FetchDataUseCase(getit<DataRepository>()));
  getit.registerFactory(() => PostDataUseCase(getit<DataRepository>()));
  getit.registerFactory(
      () => MyViewModel(getit<FetchDataUseCase>(), getit<PostDataUseCase>()));
}

class APIClient {
  final String _baseUrl;
  http.Client client;
  TokenManager tokenManager;

  APIClient._internal(this._baseUrl, this.client, this.tokenManager);

  factory APIClient(String baseUrl,
      {required http.Client client, required TokenManager tokenManager}) {
    return APIClient._internal(baseUrl, client, tokenManager);
  }

  Future<http.Response> getRequest(String endpoint) async {
    String token = tokenManager.token;
    return _makeRequest('GET', endpoint, token);
  }

  Future<http.Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    String token = tokenManager.token;
    return _makeRequest('POST', endpoint, token, data: data);
  }

  Future<http.Response> _makeRequest(
      String method, String endpoint, String token,
      {Map<String, dynamic>? data}) async {
    Uri url = Uri.parse('$_baseUrl$endpoint');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    switch (method) {
      case 'POST':
        return await http.post(url, headers: headers, body: json.encode(data));
      case 'GET':
        return await http.get(url, headers: headers);
      default:
        throw UnimplementedError('HTTP method $method not supported');
    }
  }
}
