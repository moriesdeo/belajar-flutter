import 'package:belajar_flutter/data/repositories.dart';
import 'package:belajar_flutter/domain/use_case.dart';
import 'package:belajar_flutter/domain/viewmodel.dart';
import 'package:belajar_flutter/helper/helper.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

GetIt getit = GetIt.instance;
void setupLocator() {
  getit.registerLazySingleton(() => http.Client());
  getit.registerLazySingleton(() => TokenManager());
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

  Future<http.Response> login(String email, String password) {
    return http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'email': email,
        'password': password,
      },
    );
  }

  Future<http.Response> getStories(String token, int page, int size) {
    return http.get(
      Uri.parse('$_baseUrl/stories?page=$page&size=$size'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
  }

  Future<http.Response> register(String name, String email, String password) {
    return http.post(
      Uri.parse('$_baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'name': name,
        'email': email,
        'password': password,
      },
    );
  }
}
